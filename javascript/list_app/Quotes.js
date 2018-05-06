import React, { Component } from 'react';

const quotesURL = 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json';

class Quotes extends Component {
  constructor() {
    super();
    this.state = {
      quotes: [],
      currentPage: 1,
      quotesPerPage: 15,
    };
    this.handleClick = this.handleClick.bind(this);
  }
  // add ability to change page
  handleClick(event) {
    this.setState({
      currentPage: Number(event.target.id),
    });
  }

  componentDidMount() {
    //fetch the JSON data
    fetch(quotesURL)
      .then(result => {
        return result.json();
      })
      .then(data => {
        console.log(data);
        // push JSON to component's state
        this.setState({ quotes: data.map(quote => {
            // concat the desired results (linter doesn't like it though)
            // eslint-disable-next-line
            return ('"' + quote.quote + '"' + " --" + quote.source + " in " + quote.context);
          })
        });
      });
  };

  render() {
    // set rendered variables
    const { quotes, currentPage, quotesPerPage } = this.state;

    // logic for displaying quotes
    const indexOfLast = currentPage * quotesPerPage;
    const indexOfFirst = indexOfLast - quotesPerPage;
    const currentQuotes = quotes.slice(indexOfFirst, indexOfLast);
    // render quote list items
    const renderQuotes = currentQuotes.map((quote, index) => {
      return <li key={index}>{quote}</li>;
    });

    // iterate through potential page numbers
    const pageNumbers = [];
    for (let i = 1; i <= Math.ceil(quotes.length / quotesPerPage); i++) {
      pageNumbers.push(i);
    };
    // display page numbers
    const renderPageNumbers = pageNumbers.map(number => {
      return (
        <li
          key={number}
          id={number}
          onClick={this.handleClick}
        >
          {number}
        </li>
      );
    });
    // display final results
    return (
      <div>
        <ul>
          {renderQuotes}
        </ul>
        <ul>
          {renderPageNumbers}
        </ul>
      </div>
    );
  }
};

export default Quotes;
