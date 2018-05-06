import React, { Component } from 'react';

const quotesURL = 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json';

class Display extends Component {
  constructor(props) {
    super(props);
    this.state = {
      quotes: [],
    };
  };

  componentDidMount() {
    //fetch the JSON data
    fetch(quotesURL)
      .then(result => {
        return result.json()
      })
      .then(data => {
        console.log(data);
        //push JSON to component's state
        this.setState({ quotes: data });
      });
  };

    render() {
    return (
      <div>
        {this.state.quotes.map(quote =>
          <li>"{quote.quote}" --{quote.source} in {quote.context}</li>
        )}
      </div>
    );
  };
};

export default Display;
