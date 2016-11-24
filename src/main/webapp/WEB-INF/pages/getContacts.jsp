<html>

<head>
    <meta charset="UTF-8">
    <title>Hello World!</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.6.15/browser.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
</head>

<body>

<div id="content"></div>

<script type="text/babel">

    const { Component } = React;
    const { render } = ReactDOM;

    class Contact extends Component {
        render() {
            return (
                    <li className="contact">
                        <img className="contact-image" src={this.props.image} width="60px" height="60px"/>
                        <div className="contact-info">
                            <div className="contact-name"> {this.props.name} {this.props.surename} </div>
                            <div className="contact-number"> {this.props.home} </div>
                            <div className="contact-number"> {this.props.work} </div>
                            <div>address: {this.props.address}</div>
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
            fetch(`http://localhost:8080/ContactManager/contacts`)
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
                        <h1>Contact Manager</h1>
                        <ul className="contacts-list">
                            {
                                this.state.contacts.map(function (el) {
                                    return <Contact
                                            key={el.id}
                                            name={el.name}
                                            surename={el.surename}
                                            home={el  .phoneNumbers.home}
                                            work={el.phoneNumbers.work}
                                            dob={el.dob}
                                            address={el.address}
                                            image={el.image}
                                    />;
                                })
                            }
                        </ul>
                    </div>
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
