import {
  GoogleAuthProvider,
  signInWithEmailAndPassword,
  signInWithPopup,
} from "firebase/auth";
import React from "react";
import { useState } from "react";
import { useHistory } from "react-router-dom";
import { auth, db } from "../firebase";
import { doc, setDoc } from "firebase/firestore";

function Login() {
  const [err, setErr] = useState("");
  const history = useHistory();
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [password, setPassword] = useState("");
  const [email, setEmail] = useState("");

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    await signInWithEmailAndPassword(auth, email, password)
      .then(() => {
        setEmail("");
        setPassword("");
        setLoading(false);
        setSuccess(true);
        history.push("/");
        window.location.reload();
      })
      .catch((error) => {
        setLoading(false);
        setErr(error.message);
      });
  };
  const handleGoogleLogin = async () => {
    setLoading(true);
    const provider = new GoogleAuthProvider();

    signInWithPopup(auth, provider)
      .then(async (result) => {
        const user = result.user;
        const userData = {
          username: user.displayName,
          email: user.email,
        };
        await setDoc(doc(db, "Users", user.uid), userData);
        setLoading(false);
        history.push("/");
        window.location.reload();
      })
      .catch((error) => {
        setLoading(false);
        setErr(error.message);
      });
  };

  return (
    <div className="body">
      <div className="login">
        {loading && (
          <div className="loading">
            <div className="spinner"></div>
          </div>
        )}
        {success && (
          <div className="success">
            <p>✔ Account created successfully</p>
          </div>
        )}
        <div className="avatar">
          <img
            src="https://img.icons8.com/ios/512/user-male-circle--v2.png"
            alt=""
          />
        </div>
        <h2>Login</h2>
        <h4>welcome back </h4>
        <form onSubmit={handleLogin}>
          <div className="textbox">
            <input
              type="email"
              id="email"
              placeholder="Email"
              required
              onChange={(event) => setEmail(event.target.value)}
            />
          </div>
          <div className="textbox">
            <input
              type="password"
              id="password"
              placeholder="Password"
              onChange={(event) => setPassword(event.target.value)}
              required
            />
          </div>
          <button type="submit">LOGIN</button>
          {err && <p className="error-message">{err}</p>}
        </form>
        <a href="/signIn">Don't have an account? SIGN UP</a>
        <a href="/resetPassword">Forgot credentials?</a>
        <div className="google">
          <button onClick={handleGoogleLogin}>
            <img
              src="https://img.icons8.com/fluency/512/google-logo.png"
              alt=""
            />
            <p>Sign in with google</p>
          </button>
        </div>
      </div>
    </div>
  );
}

export default Login;
