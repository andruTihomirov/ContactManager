import React from 'react';
import ReactDOM from 'react-dom';
import DatePicker from 'react-datepicker';

require('react-datepicker/dist/react-datepicker.css');

class DatePickerCustom extends React.Component {

    constructor() {
        super();
        this.state = {
            startDate: null,
            isClearable: false
        };
    }

    handleChange(date) {
        this.setState({
            startDate: date,
            isClearable: true
        });
    }

    render() {
        return (
            <DatePicker
                selected={this.state.startDate}
                onChange={this.handleChange.bind(this)}
                isClearable={this.state.isClearable}
                placeholderText="Please, input date" />
        );
    }
}

ReactDOM.render(<DatePickerCustom />, document.getElementById('datapicker'));