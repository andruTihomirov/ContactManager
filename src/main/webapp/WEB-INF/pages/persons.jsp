<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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

    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

</head>


<body>
<div>
    <a href="http://localhost:8080/ContactManager/logout">Logout</a>
</div>
<sec:authorize access="hasRole('ADMIN')">
    <div>
        <a href="http://localhost:8080/ContactManager/admin">Admin Page</a>
    </div>
</sec:authorize>
<div id="content"></div>

<script type="text/babel">

    const {Component} = React;
    const {render} = ReactDOM;
    const {Modal} = ReactBootstrap;
    const {Button} = ReactBootstrap;
    const {OverlayTrigger} = ReactBootstrap;

    class Person extends Component {
        deletePerson(id) {
            console.log("Delete: " + id);
             fetch("http://localhost:8080/ContactManager/delete/" + id, {
                 credentials: 'same-origin',
                 method: 'GET',
                 headers: {
                     'Accept': 'application/json',
                     'Content-Type': 'text/plain',
                     '${_csrf.headerName}': '${_csrf.token}',
                 }
             }).then(response => {
                 if(response.status == "200") {
                     location.reload();
                 } else {
                     alert("The record was not deleted. Something wrong!");
                 }
             });
        };

        render() {
            return (
                    <li className="contact">
                        <img className="contact-image" src={this.props.el.imagePath} width="60px" height="60px"/>
                        <div className="contact-info">
                            <div className="contact-name"> {this.props.el.name} {this.props.el.surname} </div>
                            <div>
                                {typeof(this.props.el.phones) != 'undefined' && this.props.el.phones.map(
                                        function(phone) {
                                            return <div key={phone.id} className="contact-number">{phone.number}</div>;
                                        }
                                )}
                            </div>
                            <div>address: {this.props.el.address}</div>
                            <div>
                                <EditPerson person={this.props.el}/>
                            </div>
                            <sec:authorize access="hasRole('ADMIN')">
                                <div>
                                    <Button bsStyle="danger" onClick={() => this.deletePerson(this.props.reactKey)}>Delete</Button>
                                </div>
                            </sec:authorize>
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
            fetch("http://localhost:8080/ContactManager/persons", {
                credentials: 'same-origin',
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    '${_csrf.headerName}': '${_csrf.token}',
                },
            }).then(response => {
                        return response.json();
                    }).then(json => {
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

    const EditPerson = React.createClass({
        render() {
            return (
                    <div>
                        <ModalWindow name={"Update"} person={this.props.person} actionName={"update"} />
                    </div>
            );
        }
    });


    const CreatePerson = React.createClass({
        render() {
            return (
                    <div>
                        <ModalWindow name={"Crete"} actionName={"create"} />
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

                if(typeof(this.props.person.phones) != "undefined") {
                    this.props.person.phones.map((phone, i) =>
                            newPerson.phones.push({
                                id: phone.id,
                                number: phone.number
                            })
                    );
                }

                this.setState({person: newPerson});
            }
        }

        addItem() {
            var newPerson = this.state.person;
            var newPhones = newPerson.phones.slice();
            newPhones.push({});
            newPerson.phones = newPhones;
            this.setState({
                person: newPerson
            });
        };


        deleteItem(index) {
            var newPerson = this.state.person;
            var newPhones = newPerson.phones.slice();
            newPhones.splice(index, 1);
            newPerson.phones = newPhones;
            this.setState({
                person: newPerson
            });
        };

        handleChange(fieldName, event) {
            var newPerson = this.state.person;

            if (fieldName.indexOf("phone_") !== -1) {
                var phoneId = event.target.id;

                var phoneIndex = parseInt(fieldName.substr(fieldName.indexOf("_") + 1));
                newPerson.phones[phoneIndex] = {
                    id: phoneId,
                    number: event.target.value
                };
                return;
            }

            newPerson[fieldName] = event.target.value;
            this.setState({person: newPerson});
        };

        saveAction(actionName) {
            console.log("Action Name: " + actionName);
            fetch("http://localhost:8080/ContactManager/" + actionName, {
                credentials: "same-origin",
                method: "POST",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "${_csrf.headerName}": "${_csrf.token}",
                },
                body: JSON.stringify(this.state.person)
            }).then(response => {
                if(response.status == "200") {
                    this.close();
                    location.reload();
                } else {
                    alert("The record was not added. Something wrong!");
                }
            });
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
                        <sec:authorize access="hasRole('ADMIN')">
                            <Button bsStyle="primary" bsSize="large" onClick={this.open}>
                                {this.props.name}
                            </Button>
                        </sec:authorize>
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
                                <div>
                                    {this.state.person.phones.map((phone, i) =>
                                            <Phone key={i}
                                                   reactKey={i}
                                                   phone={phone}
                                                   onChangeMethod={this.handleChange.bind(this)}
                                                   deleteItem={this.deleteItem.bind(this)} />
                                    )}
                                    <button onClick={this.addItem.bind(this)}>Add Phone</button>
                                </div>
                            </Modal.Body>
                            <Modal.Footer>
                                <Button onClick={() => this.saveAction(this.props.actionName)}>Save</Button>
                                <Button onClick={this.close}>Close</Button>
                            </Modal.Footer>
                        </Modal>
                    </div>
            );
        }
    };

    class Phone extends Component {
        render() {
            return (
                    <li>
                        <input id={typeof(this.props.phone) != "undefined" ? this.props.phone.id : ""}
                               type="text"
                               name={"phone_" + this.props.reactKey}
                               onChange={this.props.onChangeMethod.bind(this, "phone_" + this.props.reactKey)}
                               defaultValue={typeof(this.props.phone) != "undefined" ? this.props.phone.number : ""} />
                        <button onClick={this.props.deleteItem.bind(this, this.props.reactKey)}> - </button>
                    </li>
            );
        };
    }

    render(
            <ContactsList />,
            document.getElementById("content")
    );

</script>
</body>
</html>
