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

        addPhone() {
            console.log("addPhone");
            var table = document.getElementById("myTable");
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            cell1.innerHTML = "Phone";

            var inputText = document.createElement("input");
            inputText.setAttribute("id", "phoneNumbers");
            inputText.setAttribute("type", "text");
            inputText.setAttribute("name", "phoneNumbers");

            var deleteButton = document.createElement("input");
            deleteButton.setAttribute("id", "deleteButton");
            deleteButton.setAttribute("type", "button");
            // deleteButton.setAttribute("onclick", );
            deleteButton.setAttribute("value", " - ");

            cell2.appendChild(inputText);
            cell2.appendChild(deleteButton);
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
                        <div>
                            <Button onButtonClicked={this.addPhone}/>
                        </div>
                        <div>
                            <input type="submit" value="Apply" />
                        </div>
                    </form>
                    </div>
            );
        };
    };

    class Button extends Component {
        render(){
            return (
                <input type="button" onClick={this.props.onButtonClicked} value="Add phone"/>
            );
        };
    };

    render(<Person />, document.getElementById("content"));

</script>
</body>
</html>
