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
    var CONTACTS = [
        {
            id: 1,
            name: 'Darth',
            surename: 'Vader',
            phoneNumbers: {
                home: '+250966666666',
                work: '+250966366266'
            },
            dob: '01/01/1991',
            address: 'SMALLSYS INC 795 E DRAGRAM TUCSON AZ 85705 USA',
            image: '${pageContext.request.contextPath}/static/img/darth.gif'
        }, {
            id: 2,
            name: 'Princess',
            surename: 'Leia',
            phoneNumbers: {
                home: '+789589745934',
                work: '+098235567856'
            },
            dob: '01/01/1992',
            address: 'MEGASYSTEMS INC 799 E DRAGRAM SUITE 5A TUCSON AZ 85705 USA',
            image: '${pageContext.request.contextPath}/static/img/leia.gif'
        }, {
            id: 3,
            name: 'Luke',
            surename: 'Skywalker',
            phoneNumbers: {
                home: '+093495757223',
                work: '+896847825424'
            },
            dob: '01/01/1993',
            address: '200 E MAIN ST PHOENIX AZ 85123 USA',
            image: '${pageContext.request.contextPath}/static/img/luke.gif'
        }, {
            id: 4,
            name: 'Chewbacca',
            surename: 'Chewba',
            phoneNumbers: {
                home: '+234923874567',
                work: '+092834136745'
            },
            dob: '01/01/1994',
            address: '300 BOYLSTON AVE E SEATTLE WA 98102 USA',
            image: '${pageContext.request.contextPath}/static/img/chewbacca.gif'
        }
    ];

    var Contact = React.createClass({
        render: function () {
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
        }
    });

    var ContactsList = React.createClass({
        getInitialState: function () {
            return {
                displayedContacts: CONTACTS
            };
        },

        handleSearch: function (event) {
            var searchQuery = event.target.value.toLowerCase();
            var displayedContacts = CONTACTS.filter(function (el) {
                var searchValue = el.name.toLowerCase();
                return searchValue.indexOf(searchQuery) != -1;
            });

            this.setState({
                displayedContacts: displayedContacts
            });
        },

        render: function () {
            return (
                    <div className="contacts">
                        <h1>Contact Manager</h1>
                        <input type="text" placeholder="Search..." className="search-field"
                               onChange={this.handleSearch}/>
                        <ul className="contacts-list">
                            {
                                this.state.displayedContacts.map(function (el) {
                                    return <Contact
                                            key={el.id}
                                            name={el.name}
                                            surename={el.surename}
                                            home={el.phoneNumbers.home}
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
        }
    });

    ReactDOM.render(
            <ContactsList />,
            document.getElementById("content")
    );

</script>

</body>

</html>