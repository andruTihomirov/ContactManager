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

    class Person extends Component {

        constructor() {
            super();
            this.state = {
                person: []
            };
        };

        render() {
            return (
                    <div>
                    <form action="http://localhost:8080/ContactManager/add" method="POST">
                        <h1>Create Person</h1>
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
                        <div id="phonesContainer"></div>
                        <div>
                            <input type="submit" value="Apply" />
                        </div>
                    </form>
                    </div>
            );
        };
    };

    class Phones extends Component {
        deleteElement() {
            console.log("remove");
        };

        render() {
            return (
                    <ul>
                        {this.props.items.map((task, taskIndex) =>
                                <li key={taskIndex}>
                                    {task}
                                    <input type="text"></input>
                                    <button onClick={this.props.deleteTask} value={taskIndex}> - </button>
                                </li>
                        )}
                    </ul>
            );
        };
    };

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

                        <form onSubmit={this.addTask}>
                            <button> Add Phone</button>
                        </form>
                    </div>
            );
        }
    });


    render(
            <div>
                <Person />
                <PhonesViewer />
            </div>,
            document.getElementById("content"));

</script>
</body>
</html>
