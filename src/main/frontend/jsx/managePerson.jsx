import React from 'react';
import Button from 'react-bootstrap/lib/Button';
import Modal from 'react-bootstrap/lib/Modal';

import Phone from './phone.jsx';

export default class ManagePerson extends React.Component {

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
        if (typeof(this.props.person) != "undefined") {
            var newPerson = this.state.person;
            newPerson.id = this.props.person.id;
            newPerson.name = this.props.person.name;
            newPerson.surname = this.props.person.surname;
            newPerson.patronymic = this.props.person.patronymic;
            newPerson.dob = this.props.person.dob;
            newPerson.address = this.props.person.address;
            newPerson.imagePath = this.props.person.imagePath;

            if (typeof(this.props.person.phones) != "undefined") {
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
            if (response.status == "200") {
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
                                           defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.name : ""}/>
                                </td>
                            </tr>
                            <tr>
                                <td>Surname</td>
                                <td><input id="surname" name="surname" type="text"
                                           onChange={this.handleChange.bind(this, "surname")}
                                           defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.surname : ""}/>
                                </td>
                            </tr>
                            <tr>
                                <td>Patronymic</td>
                                <td><input id="patronymic" name="patronymic" type="text"
                                           onChange={this.handleChange.bind(this, "patronymic")}
                                           defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.patronymic : ""}/>
                                </td>
                            </tr>
                            <tr>
                                <td>Date Of Birth</td>
                                <td><input id="dob" name="dob" type="text"
                                           onChange={this.handleChange.bind(this, "dob")}
                                           defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.dob : ""}/>
                                </td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td><input id="address" name="address" type="text"
                                           onChange={this.handleChange.bind(this, "address")}
                                           defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.address : ""}/>
                                </td>
                            </tr>
                            <tr>
                                <td>Image Path</td>
                                <td><input id="imagePath" name="imagePath" type="text"
                                           onChange={this.handleChange.bind(this, "imagePath")}
                                           defaultValue={typeof(this.props.person) != "undefined" ? this.props.person.imagePath : ""}/>
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
                                       deleteItem={this.deleteItem.bind(this)}/>
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
