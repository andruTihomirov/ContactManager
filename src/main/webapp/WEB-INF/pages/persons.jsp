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
                        <img className="contact-image" src={this.props.imagePath} width="60px" height="60px"/>
                        <div className="contact-info">
                            <div className="contact-name"> {this.props.name} {this.props.surname} </div>
                            <div className="contact-number"> {this.props.phoneNumbers} </div>
                            <div>address: {this.props.address}</div>
                            <div><a href={"http://localhost:8080/ContactManager/edit/" + this.props.reactKey}>edit</a></div>
                            <div><a href="#">delete</a></div>
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
            fetch(`http://localhost:8080/ContactManager/persons`)
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
                                    console.log(el.id)
                                    return <Contact
                                            key={el.id}
                                            reactKey={el.id}
                                            imagePath={el.imagePath}
                                            name={el.name}
                                            surname={el.surname}
                                            phoneNumbers={el.phoneNumbers}
                                            dob={el.dob}
                                            address={el.address}
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
