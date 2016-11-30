<html>

<head>
    <meta charset="UTF-8">
    <title>Hello World!</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.0/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react-bootstrap/0.30.7/react-bootstrap.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.6.15/browser.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap-theme.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
</head>


<body>

<div id="content"></div>

<script type="text/babel">

    const { Component } = React;
    const { render } = ReactDOM;
    const { Modal } = ReactBootstrap;
    const { Button } = ReactBootstrap;
    const { OverlayTrigger } = ReactBootstrap;

    class Person extends Component {
        render() {
            return (
                    <li className="contact">
                        <img className="contact-image" src={this.props.imagePath} width="60px" height="60px"/>
                        <div className="contact-info">
                            <div className="contact-name"> {this.props.name} {this.props.surname} </div>
                            <div className="contact-number"> {this.props.phoneNumbers} </div>
                            <div>address: {this.props.address}</div>
                            <div><a href={"http://localhost:8080/ContactManager/edit/" + this.props.reactKey}>edit</a></div>
                            <div><a href={"http://localhost:8080/ContactManager/delete/" + this.props.reactKey}>delete</a></div>
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
            fetch("http://localhost:8080/ContactManager/persons")
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
                        <h1>Person Manager</h1>
                        <CreatePersonComponent />
                        <ul className="contacts-list">
                            {
                                this.state.contacts.map(function (el) {
                                    return <Person
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

    class Phones extends Component {
        deleteElement() {
            console.log("remove");
        };

        render() {
            return (
                    <ul>
                        {this.props.items.map((task, taskIndex) =>
                                <li key={taskIndex}>
                                    <input type="text" name={"phone_" + taskIndex}></input>
                                    <button onClick={this.props.deleteTask} value={taskIndex}> - </button>
                                </li>
                        )}
                    </ul>
            );
        };
    }

    var PhonesViewer = React.createClass ({
        getInitialState: function () {
            return {
                items: []
            }
        },

        deleteTask: function (e) {
            var taskIndex = parseInt(e.target.value, 10);
            console.log('remove task: %d', taskIndex);
            this.setState(state => {
                state.items.splice(taskIndex, 1);
                return {items: state.items};
            });
        },

        addTask: function (e) {
            this.setState({
                items: this.state.items.concat([this.state.task])
            });

            e.preventDefault();
        },

        render: function () {
            return (
                    <div>
                        <Phones items={this.state.items} deleteTask={this.deleteTask}/>
                        <button onClick={this.addTask}> Add Phone</button>
                    </div>
            );
        }
    });

    const CreatePersonComponent = React.createClass({
        getInitialState() {
            return { showModal: false };
        },

        save() {
            // inmplement save person
        },

        close() {
            this.setState({ showModal: false });
        },

        open() {
            this.setState({ showModal: true });
        },

        render() {

            return (
                    <div>

                        <Button bsStyle="primary" bsSize="large" onClick={this.open}>
                            Create Person
                        </Button>

                        <Modal show={this.state.showModal} onHide={this.close}>
                            <Modal.Header closeButton>
                                <Modal.Title>Create Person</Modal.Title>
                            </Modal.Header>
                            <Modal.Body>
                                <table id="myTable">
                                    <tbody>
                                    <tr>
                                        <td>Name</td>
                                        <td><input id="name" name="name" type="text" /></td>
                                    </tr>
                                    <tr>
                                        <td>Surname</td>
                                        <td><input id="surname" name="surname" type="text" /></td>
                                    </tr>
                                    <tr>
                                        <td>Patronymic</td>
                                        <td><input id="patronymic" name="patronymic" type="text" /></td>
                                    </tr>
                                    <tr>
                                        <td>Phone Numbers</td>
                                        <td><input id="phoneNumbers" name="phoneNumbers" type="text" /></td>
                                    </tr>
                                    <tr>
                                        <td>Date Of Birth</td>
                                        <td><input id="dob" name="dob" type="text" /></td>
                                    </tr>
                                    <tr>
                                        <td>Address</td>
                                        <td><input id="address" name="address" type="text" /></td>
                                    </tr>
                                    <tr>
                                        <td>Image Path</td>
                                        <td><input id="imagePath" name="imagePath" type="text" /></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <PhonesViewer />
                            </Modal.Body>
                            <Modal.Footer>
                                <Button onClick={this.save}>Save</Button>
                                <Button onClick={this.close}>Close</Button>
                            </Modal.Footer>
                        </Modal>
                    </div>
            );
        }
    });


    render(
            <ContactsList />,
            document.getElementById("content")
    );

</script>
</body>
</html>
