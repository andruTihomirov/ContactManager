import React from 'react';
import Modal from 'react-bootstrap/lib/Modal';

export default class ModalWindow extends React.Component {

    render() {
        const isShowModal = this.props.isShowModal;
        const modalTitle = this.props.modalTitle;
        const person = this.props.person;
        const actionName = this.props.actionName;

        return (
            <Modal show={isShowModal} onHide={this.close}>
                <Modal.Header closeButton>
                    <Modal.Title>{modalTitle}</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <table id="myTable">
                        <tbody>
                        <tr>
                            <td>Name</td>
                            <td><input id="name" name="name" type="text"
                                       onChange={this.handleChange.bind(this, "name")}
                                       defaultValue={typeof(person) != "undefined" ? person.name : ""} />
                            </td>
                        </tr>
                        <tr>
                            <td>Surname</td>
                            <td><input id="surname" name="surname" type="text"
                                       onChange={this.handleChange.bind(this, "surname")}
                                       defaultValue={typeof(person) != "undefined" ? person.surname : ""} />
                            </td>
                        </tr>
                        <tr>
                            <td>Patronymic</td>
                            <td><input id="patronymic" name="patronymic" type="text"
                                       onChange={this.handleChange.bind(this, "patronymic")}
                                       defaultValue={typeof(person) != "undefined" ? person.patronymic : ""} />
                            </td>
                        </tr>
                        <tr>
                            <td>Date Of Birth</td>
                            <td><input id="dob" name="dob" type="text"
                                       onChange={this.handleChange.bind(this, "dob")}
                                       defaultValue={typeof(person) != "undefined" ? person.dob : ""} />
                            </td>
                        </tr>
                        <tr>
                            <td>Address</td>
                            <td><input id="address" name="address" type="text"
                                       onChange={this.handleChange.bind(this, "address")}
                                       defaultValue={typeof(person) != "undefined" ? person.address : ""} />
                            </td>
                        </tr>
                        <tr>
                            <td>Image Path</td>
                            <td><input id="imagePath" name="imagePath" type="text"
                                       onChange={this.handleChange.bind(this, "imagePath")}
                                       defaultValue={typeof(person) != "undefined" ? person.imagePath : ""} />
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div>
                        {person.phones.map((phone, i) =>
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

                </Modal.Footer>
            </Modal>
        );
    };

}