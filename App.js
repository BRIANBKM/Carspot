import "./style.scss";
import Home from "./components/pages/Home";
import Navbar from "./components/navbar";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Sell from "./components/pages/Sell";
import Dealers from "./components/pages/dealers";
import Account from "./components/pages/account";
import Footer from "./components/footer";
import Login from "./components/pages/login";
import Signin from "./components/pages/signin";
import ResetPasswordPage from "./components/pages/resetpassword";

function App() {
  return (
    <div className="app">
      <Router>
        <div className="navsize">
          <Navbar />
        </div>
        <Switch>
          <Route path="/" exact component={Home} />
          <Route path="/sell_your_car" component={Sell} />
          <Route path="/dealer" component={Dealers} />
          <Route path="/account" component={Account} />
          <Route path="/signIn" component={Signin} />
          <Route path="/login" component={Login} />
          <Route path="/resetPassword" component={ResetPasswordPage} />
          
        </Switch>
        <div className="footersize">
          <Footer />
        </div>
      </Router>
    </div>
  );
}

export default App;
