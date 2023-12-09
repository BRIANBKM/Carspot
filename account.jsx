import { signOut } from "firebase/auth";
import React, { useState, useEffect } from "react";
import { useHistory } from "react-router-dom";
import { Link } from "react-router-dom";
import { collection, doc, deleteDoc, setDoc } from "firebase/firestore";
import { db, auth } from "../firebase";
import { where, query, getDocs } from "firebase/firestore";
import Snackbar from "@material-ui/core/Snackbar";

function Account() {
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const collectionNames = [
    "Audi",
    "Bentley",
    "BMW",
    "Chevrolet",
    "Ford",
    "GMC",
    "Honda",
    "Hyundai",
    "Isuzu",
    "Jaguar",
    "Jeep",
    "Land_Rover",
    "Lexus",
    "Mazda",
    "Mercedes_Benz",
    "Mistubishi",
    "Nissan",
    "Peugeot",
    "Porche",
    "Proton",
    "Renault",
    "Roll_Royce",
    "Subaru",
    "Suzuki",
    "Toyota",
    "Volkswagen",
    "Volvo",
  ];
  const history = useHistory();
  const [MyCars, setMyCars] = useState();
  const [loading, setLoading] = useState(true);

  const user = auth.currentUser;

  async function handleDelete(create, collect, email, brand, model) {
    const carCollectionRef = collection(db, "CARS", "carsId", collect);
    const docRef = doc(carCollectionRef, create);
    const soldRef = collection(db, "SOLD");
    const carRef = doc(soldRef);
    try {
      const carData = {
        email,
        brand,
        model,
      };
      await setDoc(carRef, carData);
      await deleteDoc(docRef);
      setSnackbarOpen(true);
      history.push("/account");
      console.log("Document deleted successfully!");
    } catch (error) {
      console.error("Error deleting document: ", error);
    }
    history.push("/account");
  }
  const handleSnackbarClose = () => {
    setSnackbarOpen(false);
  };

  useEffect(() => {
    if (!user || !user.email) {
      setMyCars("");
      return;
    }
    const promises = collectionNames.map((collectionName) =>
      getDocs(
        query(
          collection(db, "CARS", "carsId", collectionName),
          where("email", "==", user.email)
        )
      )
    );
    Promise.all(promises).then((snapshotsArray) => {
      const allCarsData = [];
      snapshotsArray.forEach((snapshot) => {
        const carsData = snapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        allCarsData.push(...carsData);
      });
      setMyCars(allCarsData);

      setLoading(false);
    });

    // return () => unsubscribe();
  }, []);

  const handleSignOut = () => {
    signOut(auth)
      .then(() => {
        window.location.reload();
        history("/");
      })
      .catch((error) => {});
  };

  return (
    <div className="accountPage">
      <div className="home">
        <span>
          <div className="carLogo">
            <span>Manage my sell</span>
          </div>
        </span>
        <form onSubmit={handleSignOut}>
          <button type="submit">SIGN OUT</button>
        </form>
      </div>
      <div className="components">
        <div className="header">
          <img
            src="https://img.icons8.com/external-tal-revivo-bold-tal-revivo/256/external-MyCars-is-a-french-automotive-manufacturer-part-of-groupe-psa-automotive-bold-tal-revivo.png"
            alt=""
          />
          <h1>My Cars</h1>
        </div>
        {loading ? (
          <div className="loading">
            <div className="spinner"></div>
          </div>
        ) : MyCars.length ? (
          <div className="columns">
            {MyCars.map((MyCar, index) => (
              <div className="card">
                <img
                  src={`https://firebasestorage.googleapis.com/v0/b/carspot-444ed.appspot.com/o/${encodeURIComponent(
                    MyCar.images
                  )}?alt=media&token=91734acf-e7dc-4880-929d-9fbfdcc513e2`}
                  alt=""
                />
                <div className="essentials">
                  <span>
                    <p>{MyCar.brand}</p>
                    <p>
                      {MyCar.model.charAt(0).toUpperCase() +
                        MyCar.model.slice(1)}
                    </p>
                  </span>
                </div>
                <>
                  <Snackbar
                    open={snackbarOpen}
                    autoHideDuration={3000}
                    onClose={handleSnackbarClose}
                    message="Document deleted successfully!"
                  />
                </>
                <button
                  onClick={(e) =>
                    handleDelete(
                      MyCar.images.toString().split("/")[1],
                      MyCar.brand.toString(),
                      MyCar.email.toString(),
                      MyCar.brand.toString(),
                      MyCar.model.toString()
                    )
                  }
                >
                  Mark as Sold
                </button>
              </div>
            ))}
          </div>
        ) : (
          <h3>No entries found.</h3>
        )}
      </div>
    </div>
  );
}

export default Account;
