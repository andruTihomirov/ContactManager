import React from 'react';
import ReactDOM from 'react-dom';
import DatePicker from 'react-datepicker';

require('react-datepicker/dist/react-datepicker.css');
 
var DatePickerCustom = React.createClass({
 
  getInitialState: function() {
    return {
      startDate: null,
	  isClearable: false
    };
  },
 
  handleChange: function(date) {
    this.setState({
      startDate: date,
	  isClearable: true
    });
  },
 
  render: function() {
    return (
		<DatePicker
			selected={this.state.startDate}
			onChange={this.handleChange}
			isClearable={this.state.isClearable}
			placeholderText="Please, input date" />
	);
  }
});
 
ReactDOM.render(<DatePickerCustom />, document.getElementById('datapicker'));