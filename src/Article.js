import React, { Component } from "react";
import MessageContract from "../build/contracts/Message.json";
import getWeb3 from "./utils/getWeb3";
import "./css/oswald.css";
import "./css/open-sans.css";
import "./css/pure-min.css";
import "./Article.css";

class Article extends Component {
  constructor (props) {
    super(props);

    this.state = {
      web3: null,
      authorAddress: null,
      authorNickName: props.match.params.nickName,
      title: props.match.params.title,
      body: null,
      viewCount: null,
    };

    // console.log(this.state.authorNickName);
    // console.log(this.state.title);
  }

  componentWillMount () {
    // Get network provider and web3 instance.
    // See utils/getWeb3 for more info.

    getWeb3.then(results => {
      this.setState({
        web3: results.web3,
      });

      // Instantiate contract once web3 provided.
      this.instantiateContract();
    }).catch(() => {
      console.log("Error finding web3.");
    });
  }

  instantiateContract () {
    /*
     * SMART CONTRACT EXAMPLE
     *
     * Normally these functions would be called in the context of a
     * state management library, but for convenience I've placed them here.
     */

    const contract = require("truffle-contract");
    const message = contract(MessageContract);
    message.setProvider(this.state.web3.currentProvider);

    // Get accounts.
    this.state.web3.eth.getAccounts((error, accounts) => {
      message.deployed().then((instance) => {
        return instance.getArticleByURL.call("SkyFather",
          "fuck-you", {from: accounts[0]});
      }).then((result) => {
        // Update state with the result.
        console.log(result);
        return this.setState({
          authorAddress: result[0],
          authorNickName: result[1],
          title: result[2],
          body: result[3],
          viewCount: result[4].c[0],
        });

      }).catch((error) => {
        console.log(error);
      });
    });
  }

  render () {
    return (
      <div className="Article">
        <nav className="navbar pure-menu pure-menu-horizontal">
          <a href="#" className="pure-menu-heading pure-menu-link">Truffle
            Box</a>
        </nav>

        <main className="container">
          <div className="pure-g">
            <div className="pure-u-1-1">
              <h1>Good to Go!</h1>
              <p>{this.state.authorAddress}</p>
              <p>{this.state.authorNickName}</p>
              <p>{this.state.title}</p>
              <p>{this.state.body}</p>
              <p>{this.state.viewCount}</p>
            </div>
          </div>
        </main>
      </div>
    );
  }
}

export default Article;
