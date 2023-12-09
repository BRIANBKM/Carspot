import React, { useState } from "react";
import { auth } from "../firebase";
import "firebase/auth";

const ResetPasswordPopup = () => {
  const [email, setEmail] = useState("");
  const [message, setMessage] = useState(null);
  const [isPopupOpen, setPopupOpen] = useState(true);

  const handleResetPassword = async (e) => {
    e.preventDefault();
    try {
      await auth().sendPasswordResetEmail(email);
      setMessage("Password reset email sent. Please check your email.");
    } catch (error) {
      setMessage(error.message);
    }
  };

  const handleClosePopup = () => {
    setPopupOpen(false);
  };

  if (!isPopupOpen) {
    return null; // If the popup is closed, return null to hide the popup
  }

  return (
    <div className="popup-overlay">
      {" "}
      {/* create a div for the popup overlay */}
      <div className="popup-container">
        {" "}
        {/* create a div for the popup content */}
        <form onSubmit={handleResetPassword}>
          <h1>Reset Password</h1>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Email"
            required
          />
          <button type="submit">Reset Password</button>
          {message && <p className="error-message">{message}</p>}
        </form>
        <button className="popup-close-button" onClick={handleClosePopup}>
          Close
        </button>{" "}
        {/* create a button to close the popup */}
      </div>
    </div>
  );
};

export default ResetPasswordPopup;
