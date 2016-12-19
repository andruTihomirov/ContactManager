import React from 'react';
import ManagePerson from './managePerson.jsx';

export default class EditPerson extends React.Component {

    render() {
        return (
            <div>
                <ManagePerson name={"Update"} person={this.props.person} actionName={"update"} />
            </div>
        );
    }

};
