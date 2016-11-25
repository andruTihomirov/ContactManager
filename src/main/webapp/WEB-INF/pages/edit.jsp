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
<h1>edit</h1>
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

        componentDidMount() {
            fetch("http://localhost:8080/ContactManager/edit/"  + this.props.reactKey)
                    .then(response => {
                        return response.json();
                    })
                    .then(json => {
                        this.setState({contacts: json});
                    });
        };


        render() {
            return (
                    <div>
                        <div>
                            <label htmlFor="name">Name: </label>
                            <input id="name" label="name" name="name" type="text" placeholder=""/>
                        </div>
                        <div>
                            <label htmlFor="surname">Surname: </label>
                            <input id="surname" label="surname" name="surname" type="text" />
                        </div>
                        <div>
                            <label htmlFor="patronymic">Patronymic: </label>
                            <input id="patronymic" label="patronymic" type="patronymic" />
                        </div>
                        <div>
                            <label htmlFor="phoneNumbers">Phone Numbers: </label>
                            <input id="phoneNumbers" label="phoneNumbers" type="phoneNumbers" />
                        </div>
                        <div>
                            <label htmlFor="dob">DOB: </label>
                            <input id="dob" label="dob" type="dob" />
                        </div>
                        <div>
                            <label htmlFor="address">Address: </label>
                            <input label="address" type="address" />
                        </div>
                        <div>
                            <button>Apply</button>
                        </div>
                    </div>
            );
        };
    }

    render(<Person />, document.getElementById("content"));

</script>
</body>
</html>