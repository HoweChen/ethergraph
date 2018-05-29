import React from "react";
import ReactDOM from "react-dom";
import App from "./App";
import Publish from "./Publish";
import Article from "./Article";
import { Route } from "react-router";
import { BrowserRouter } from "react-router-dom";

// ReactDOM.render(
//   <Article/>,
//   document.getElementById("root"),
// );

/*
* [] TODO: do the contract
* [] TODO: do the publish page
* [] TODO: do the article page
* */

ReactDOM.render(
  (<div>
    <BrowserRouter>
      <div>
        <Route path='/app' component={App}></Route>
      </div>
    </BrowserRouter>
    <BrowserRouter>
      <div>
        <Route path='/publish' component={Publish}></Route>
      </div>
    </BrowserRouter>
    <BrowserRouter>
      <div>
        <Route path='/article/@:nickName/:title' component={Article}></Route>
      </div>
    </BrowserRouter>
  </div>),
  document.getElementById("root"),
);
