import React from 'react';

export default class Phone extends React.Component {
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
