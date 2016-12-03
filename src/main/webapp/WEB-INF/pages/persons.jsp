<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>

<head>
    <meta charset="UTF-8">
    <title>Hello World!</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react-bootstrap/0.30.7/react-bootstrap.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.6.15/browser.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap-theme.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
</head>


<body>

<div id="content"></div>

<script type="text/babel">

    const {Component} = React;
    const {render} = ReactDOM;
    const {Modal} = ReactBootstrap;
    const {Button} = ReactBootstrap;
    const {OverlayTrigger} = ReactBootstrap;

    class Person extends Component {
        render() {
            return (
                    <li className="contact">
                        <img className="contact-image" src={this.props.el.imagePath} width="60px" height="60px"/>
                        <div className="contact-info">
                            <div className="contact-name"> {this.props.el.name} {this.props.el.surname} </div>
                            <div>
                                {this.props.el.phones.map(
                                        function(phone) {
                                            return <div key={phone.id} className="contact-number">{phone.number}</div>;
                                        }
                                )}
                            </div>
                            <div>address: {this.props.el.address}</div>
                            <div>
                                <EditPerson person={this.props.el}/>
                            </div>
                            <div>
                                <a href={"http://localhost:8080/ContactManager/delete/" + this.props.reactKey}>delete</a>
                            </div>
                        </div>
                    </li>
            );
        };
    }

    class ContactsList extends Component {

        constructor() {
            super();
            this.state = {
                contacts: []
            };
        };

        componentDidMount() {
            fetch("http://localhost:8080/ContactManager/persons")
                    .then(response => {
                        return response.json();
                    })
                    .then(json => {
                        this.setState({contacts: json});
                    });
        };

        render() {
            return (
                    <div className="contacts">
                        <h1>Person Manager</h1>
                        <CreatePerson />
                        <ul className="contacts-list">
                            {
                                this.state.contacts.map(function (el) {
                                    return <Person key={el.id} reactKey={el.id} el={el}/>;
                                })
                            }
                        </ul>
                    </div>
            );
        };
    }

    class Phone extends Component {
        render() {
            return (
                    <li>
                        <input type="text" name={"phone_" + this.props.reactKey}
                               onChange={this.props.onChangeMethod.bind(this, "phone_" + this.props.reactKey)}
                               defaultValue={typeof(this.props.phone) != "undefined" ? this.props.phone : ""}/>
                        <button onClick={this.props.deleteItem}> - </button>
                    </li>
            );
        };
    }

    class PhonesViewer extends Component {
        constructor() {
            super();
            this.state = {
                phones: []
            };
        };

        componentDidMount() {
            if(this.props.phones !=  "undefined") {
                var newArray = this.state.phones.slice();
                this.props.phones.map((phone, i) => {
                    newArray.push(<Phone key={phone.id}
                                         reactKey={i}
                                         phone={phone.number}
                                         deleteItem={this.deleteItem.bind(this)}
                                         onChangeMethod={this.props.onChangeMethod} />);
                });
                this.setState({
                    phones: newArray
                });
            }
        };

        addItem(e) {
            var i = this.state.phones.length;
            this.setState({
                phones: this.state.phones.concat(<Phone deleteItem={this.deleteItem.bind(this)}
                                                        reactKey={i}
                                                        onChangeMethod={this.props.onChangeMethod}/>)
            });
        };

        deleteItem(e) {
            var newData = this.state.phones.slice();
            newData.splice(0, 1);
            this.setState({
                phones: newData
            });
        };

        render() {
            var coms = [];
            return (
                    <div>
                        {[...Array(this.state.phones)].map((phone, i) =>
                                phone
                        )}
                        <button onClick={this.addItem.bind(this)}>Add Phone</button>
                    </div>
            )
        };
    };

    const EditPerson = React.createClass({

        updateAction(person) {
            console.log("update");
            console.log(person);
            fetch('http://localhost:8080/ContactManager/update', {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(person)
            });
        },

        render() {
            return (
                <div>
                    <ModalWindow name={"Update"} person={this.props.person} saveAction={this.updateAction} />
                </div>
            );
        }
    });


    const CreatePerson = React.createClass({

        saveAction(person) {
            console.log("create");
            fetch('http://localhost:8080/ContactManager/create', {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(person)
            });
        },

        render() {
            return (
                <div>
                    <ModalWindow name={"Crete"} saveAction={this.saveAction} />
                </div>
            );
        }
    });


    class ModalWindow extends Component {

        constructor() {
            super();
            this.state = {
                showModal: false,
                person: {
                    id: null,
                    name: "",
                    surname: "",
                    patronymic: "",
                    dob: "",
                    address: "",
                    imagePath: "",
                    phones: []
                }
            };

            this.close = this.close.bind(this);
            this.open = this.open.bind(this);
        };

        componentDidMount() {
            if(typeof(this.props.person) != "undefined") {
                var newPerson = this.state.person;
                newPerson.id = this.props.person.id;
                newPerson.name = this.props.person.name;
                newPerson.surname = this.props.person.surname;
                newPerson.patronymic = this.props.person.patronymic;
                newPerson.dob = this.props.person.dob;
                newPerson.address = this.props.person.address;
                newPerson.imagePath = this.props.person.imagePath;

                this.props.person.phones.map((phone, i) =>
                        newPerson.phones.push({
                            id: phone.id,
                            number: phone.number
                        })
                );

                this.setState({person: newPerson});
            }
        }

        handleChange(fieldName, event) {
            var newPerson = this.state.person;

            if (fieldName.indexOf("phone_") !== -1) {
                var phoneIndex = parseInt(fieldName.substr(fieldName.indexOf("_") + 1));
//                var id = null;
//                if (this.state.person.phones.length > 0) {
//                    this.props.person.phones.map((phone, i) => {
//                        if(phone.number == this.props.person.phones[phoneIndex].number) {
//                            id = parseInt(phone.id);
//                                newPerson.phones[phoneIndex] = {
//                                    id: id,
//                                    number: event.target.value
//                                };
//                        }
//                    });
//                    return;
//                }
                newPerson.phones[phoneIndex] = {
                    number: event.target.value
                };
                return;
            }

            newPerson[fieldName] = event.target.value;
            this.setState({person: newPerson});
        }

        close() {
            this.setState({showModal: false});
        };

        open() {
            this.setState({showModal: true});
        };

        render() {
            return (
                <div>
                <Button bsStyle="primary" bsSize="large" onClick={this.open}>
                    {this.props.name}
                </Button>
                <Modal show={this.state.showModal} onHide={this.close}>
                    <Modal.Header closeButton>
                        <Modal.Title>{this.props.name}</Modal.Title>
                    </Modal.Header>
                        <Modal.Body>
                            <table id="myTable">
                                <tbody>
                                <tr>
                                    <td>Name</td>
                                    <td><input id="name" name="name" type="text"
                                            onChange={this.handleChange.bind(this, "name")}
                                            defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.name : ""} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Surname</td>
                                    <td><input id="surname" name="surname" type="text"
                                            onChange={this.handleChange.bind(this, "surname")}
                                            defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.surname : ""} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Patronymic</td>
                                    <td><input id="patronymic" name="patronymic" type="text"
                                            onChange={this.handleChange.bind(this, "patronymic")}
                                            defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.patronymic : ""} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Date Of Birth</td>
                                    <td><input id="dob" name="dob" type="text"
                                            onChange={this.handleChange.bind(this, "dob")}
                                            defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.dob : ""} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td><input id="address" name="address" type="text"
                                            onChange={this.handleChange.bind(this, "address")}
                                            defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.address : ""} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Image Path</td>
                                    <td><input id="imagePath" name="imagePath" type="text"
                                            onChange={this.handleChange.bind(this, "imagePath")}
                                            defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.imagePath : ""} />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <PhonesViewer phones={typeof(this.props.person) != "undefined" ? this.props.person.phones : "undefined"}
                                onChangeMethod={this.handleChange.bind(this)} />
                        </Modal.Body>
                        <Modal.Footer>
                            <Button onClick={() => this.props.saveAction(this.state.person)}>Save</Button>
                            <Button onClick={this.close}>Close</Button>
                        </Modal.Footer>

                </Modal>
                </div>
            );
        }
    };

    render(
            <ContactsList />,
            document.getElementById("content")
    );

</script>
</body>
</html>
