import React from 'react';
import axios from 'axios';

import EditPerson from './editPerson.jsx';

export default class Person extends React.Component {
    deletePerson(id) {
        axios("http://localhost:8080/ContactManager/delete/" + id, {
            credentials: 'same-origin',
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'text/plain',
            }
        }).then(response => {
            if (response.status == "200") {
                location.reload();
            } else {
                alert("The record was not deleted. Something wrong!");
            }
        });
    };

    render() {
        const person = this.props.person;
        const imagePath = person.imagePath;
        const name = person.name;
        const surname = person.surname;
        const phones = person.phones;
        const address = person.address;

        return (
            <li className="contact">
                <img className="contact-image" src={imagePath} width="60px" height="60px"/>
                <div className="contact-info">
                    <div className="contact-name"> {name} {surname} </div>
                    <div>
                        {typeof(phones) != 'undefined' && phones.map(
                            function (phone) {
                                return <div key={phone.id} className="contact-number">{phone.number}</div>;
                            }
                        )}
                    </div>
                    <div>address: {address}</div>
                    <div>
                        <EditPerson person={person}/>
                    </div>
                    <div>

                    </div>
                </div>
            </li>
        );
    };
}
