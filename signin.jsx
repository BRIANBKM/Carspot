import React from "react";
import { useState } from "react";
import { auth, db } from "../firebase";
import { useHistory } from "react-router-dom";
import { doc, setDoc } from "firebase/firestore";
import { updateProfile } from "firebase/auth";

import "firebase/auth";
import {
  createUserWithEmailAndPassword,
  GoogleAuthProvider,
  signInWithPopup,
} from "firebase/auth";

function Signin() {
  const [err, setErr] = useState(null);
  const history = useHistory();
  const [email, setEmail] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const res = await createUserWithEmailAndPassword(auth, email, password);
      await setDoc(doc(db, "Users", res.user.uid), {
        uid: res.user.uid,
        username,
        email,
      });
      await updateProfile(auth.currentUser, {
        displayName: username,
      });
      setEmail("");
      setPassword("");
      setUsername("");
      setLoading(false);
      setSuccess(true);
      history.push("/");
      window.location.reload();
    } catch (error) {
      setLoading(false);
      setErr(error.message);
    }
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
        window.location.reload();
        history.push("/");
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
        <h2>REGISTER</h2>
        <h4>welcome </h4>
        <form onSubmit={handleSubmit}>
          <div className="textbox">
            <input
              type="text"
              id="username"
              value={username}
              onChange={(event) => setUsername(event.target.value)}
              placeholder="Username"
              required
            />
          </div>
          <div className="textbox">
            <input
              type="email"
              id="email"
              placeholder="email"
              value={email}
              onChange={(event) => setEmail(event.target.value)}
              required
            />
          </div>
          <div className="textbox">
            <input
              type="password"
              id="password"
              value={password}
              onChange={(event) => setPassword(event.target.value)}
              placeholder="Password"
              required
            />
          </div>
          <button>Sign up</button>
          {err && <p className="error-message">{err}</p>}
        </form>
        <a href="/account">Already have account? LOGIN</a>
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

export default Signin;
