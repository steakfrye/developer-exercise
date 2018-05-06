import React, { Component } from 'react';

const quotesURL = 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      quotes: [],
    };
  };

  componentDidMount() {
    fetch(quotesURL)
      .then(result => {
        return result.json()
      })
      .then(data => {
        console.log(data);
        this.setState({ quotes: data });
      });
  };

    render() {
    return (
      <div>
        <ul>
          {this.state.quotes.map(quote =>
            <li>"{quote.quote}" --{quote.source} in {quote.context}</li>
          )}
        </ul>
      </div>
    );
  };
};

export default App;
