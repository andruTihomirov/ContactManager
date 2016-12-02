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
                        <input type="text" name={"phones[" + this.props.reactKey + "].number"}
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
                    newArray.push(<Phone key={phone.id} phone={phone.number} deleteItem={this.deleteItem.bind(this)} />);
                });
                this.setState({
                    phones: newArray
                });
            }
        };

        addItem(e) {
            this.setState({
                phones: this.state.phones.concat(<Phone deleteItem={this.deleteItem.bind(this)} />)
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

        updateAction() {
            console.log("update " + this.props.person.name);
        },

        render() {
            return (
                <div>
                    <ModalWindow name={"Update Person"} person={this.props.person} saveAction={this.updateAction} />
                </div>
            );
        }
    });


    const CreatePerson = React.createClass({

        saveAction() {
            console.log("save");
        },

        render() {
            return (
                <div>
                    <ModalWindow name={"Crete Person"} saveAction={this.saveAction} />
                </div>
            );
        }
    });


    const ModalWindow = React.createClass({

        getInitialState() {
            return {showModal: false};
        },

        close() {
            this.setState({showModal: false});
        },

        open() {
            this.setState({showModal: true});
        },

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
                                        defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.name : ""} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Surname</td>
                                    <td><input id="surname" name="surname" type="text"
                                        defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.surname : ""}/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Patronymic</td>
                                    <td><input id="patronymic" name="patronymic" type="text"
                                        defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.patronymic : ""}/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Phone Numbers</td>
                                    <td><input id="phoneNumbers" name="phoneNumbers" type="text"
                                        defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.phoneNumbers : ""}/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Date Of Birth</td>
                                    <td><input id="dob" name="dob" type="text"
                                        defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.dob : ""}/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td><input id="address" name="address" type="text"
                                        defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.address : ""}/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Image Path</td>
                                    <td><input id="imagePath" name="imagePath" type="text"
                                        defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.imagePath : ""}/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <PhonesViewer phones={typeof(this.props.person) != "undefined" ? this.props.person.phones : "undefined"}/>
                        </Modal.Body>
                        <Modal.Footer>
                            <input bsStyle="primary" bsSize="large" type="submit" value="Apply"/>
                            <Button onClick={this.props.saveAction}>Save</Button>
                            <Button onClick={this.close}>Close</Button>
                        </Modal.Footer>

                </Modal>
                </div>
            );
        }
    });

    render(
            <ContactsList />,
            document.getElementById("content")
    );

</script>
</body>
</html>
