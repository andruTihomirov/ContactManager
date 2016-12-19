import React from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';

import Person from './person.jsx';

class Persons extends React.Component {

    constructor() {
        super();
        this.state = {
            persons: []
        };
    };

    componentDidMount() {
        axios("http://localhost:8080/ContactManager/persons", {
            credentials: 'same-origin',
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
            },
        }).then(response => {
            return response.data;
        }).then(data => {
            this.setState({persons: data});
        });
    };

    render() {
        return (
            <div className="contacts">
                <h1>Person Manager</h1>
                <ul className="contacts-list">
                    {
                        this.state.persons.map(function (person) {
                            return <Person key={person.id} reactKey={person.id} person={person}/>;
                        })
                    }
                </ul>
            </div>
        );
    };
}

ReactDOM.render(
    <Persons />,
    document.getElementById("content")
);
