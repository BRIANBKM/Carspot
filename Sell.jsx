import React from "react";
import { useState } from "react";
import { auth, db, storage } from "../firebase";
import { doc, collection, setDoc } from "firebase/firestore";
import { ref, uploadBytesResumable } from "firebase/storage";
import { useHistory } from "react-router-dom";

export default function Sell() {
  const [brand, setBrand] = useState("");
  const [model, setModel] = useState("");
  const [fuelType, setFuelType] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [loading, setLoading] = useState(false);
  const [carPictures, setCarPictures] = useState(null);
  const [location, setLocation] = useState("");
  const [price, setPrice] = useState("");
  const [year, setYear] = useState("");
  const [transmission, setTransmission] = useState("");
  const [mileage, setMileage] = useState("");
  const [err, setErr] = useState("");
  const history = useHistory();
  const user = auth.currentUser;

  const handleSell = async (event) => {
    event.preventDefault();

    setLoading(true);
    if (
      (brand === "" &&
        model === "" &&
        fuelType === "" &&
        year === "" &&
        transmission === "" &&
        mileage === "" &&
        phoneNumber === "" &&
        location === "" &&
        price === "") ||
      !user
    ) {
      alert("You need to be logged in to sell a car.");
      setLoading(false);
      history("/login");
      return;
    }

    try {
      const email = user.email;
      if (brand === "Audi") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Audi");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Audi/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Bentley") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Bentley");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Bentley/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "BMW") {
        const carCollectionRef = collection(db, "CARS", "carsId", "BMW");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `BMW/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Chevrolet") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Chevrolet");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Chevrolet/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Ford") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Ford");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Ford/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "GMC") {
        const carCollectionRef = collection(db, "CARS", "carsId", "GMC");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `GMC/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Honda") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Honda");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Honda/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Hyundai") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Hyundai");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Hyundai/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Isuzu") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Isuzu");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Isuzu/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Jaguar") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Jaguar");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Jaguar/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Jeep") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Jeep");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Jeep/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Land_Rover") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Land_Rover");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Land_Rover/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Lexus") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Lexus");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Lexus/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Mazda") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Mazda");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Mazda/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Mercedes_Benz") {
        const carCollectionRef = collection(
          db,
          "CARS",
          "carsId",
          "Mercedes Benz"
        );
        const carStorageRef = ref(storage, `Mercedes Benz/${carRef.id}`);
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Mitsubishi") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Mitsubishi");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Mitsubishi/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Nissan") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Nissan");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Nissan/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Peugeot") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Peugeot");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Peugeot/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Porche") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Porche");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Porche/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Proton") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Proton");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Proton/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Renault") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Renault");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Renault/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Roll_Royce") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Roll Royce");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Roll Royce/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Subaru") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Subaru");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Subaru/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Suzuki") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Suzuki");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Suzuki/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Toyota") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Toyota");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Toyota/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Volkswagen") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Volkswagen");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Volkswagen/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      } else if (brand === "Volvo") {
        const carCollectionRef = collection(db, "CARS", "carsId", "Volvo");
        const carRef = doc(carCollectionRef, `${Date.now()}`);
        const carStorageRef = ref(storage, `Volvo/${carRef.id}`);
        const uploadTask = uploadBytesResumable(carStorageRef, carPictures);
        const snapshot = await uploadTask;
        const carData = {
          email,
          brand,
          model,
          fuelType,
          year,
          transmission,
          mileage,
          phoneNumber,
          location,
          price,
          images: [snapshot.metadata.fullPath],
          createdAt: Date.now(),
        };
        await setDoc(carRef, carData);
      }
      setBrand("");
      setModel("");
      setFuelType("");
      setPhoneNumber("");
      setCarPictures(null);
      setMileage("");
      setYear("");
      setTransmission("");
      setLocation("");
      setPrice("");
      setLoading(false);
      window.location.reload();
    } catch (error) {
      setErr(error);
      setLoading(false);
    }
  };

  return (
    <div className="selling">
      <div className="sell">
        <form onSubmit={handleSell}>
          <h1>SELL MY CAR</h1>
          <select
            required
            id="menu"
            name="menu"
            onChange={(e) => setBrand(e.target.value)}
          >
            <option value="" disabled selected>
              Choose car brand:
            </option>
            <option value="Audi">Audi</option>
            <option value="Bentley">Bentley</option>
            <option value="BMW">BMW</option>
            <option value="Chevrolet">Chevrolet</option>
            <option value="Ford">Ford</option>
            <option value="GMC">GMC</option>
            <option value="Honda">Honda</option>
            <option value="Hyundai">Hyundai</option>
            <option value="Isuzu">Isuzu</option>
            <option value="Jaguar">Jaguar</option>
            <option value="Jeep">Jeep</option>
            <option value="Land_rover">Land Rover</option>
            <option value="Lexus">Lexus</option>
            <option value="Mazda">Mazda</option>
            <option value="Mercedes_Benz">Mercedes Benz</option>
            <option value="Mitsubishi">Mitsubishi</option>
            <option value="Nissan">Nissan</option>
            <option value="Peugeot">Peugeot</option>
            <option value="Porche">Porche</option>
            <option value="Proton">Proton</option>
            <option value="Renault">Renault</option>
            <option value="Roll_Royce">Roll Royce</option>
            <option value="Subaru">Subaru</option>
            <option value="Suzuki">Suzuki</option>
            <option value="Toyota">Toyota</option>
            <option value="Volkswagen">Volkswagen</option>
            <option value="Volvo">Volvo</option>
          </select>
          <input
            type="text"
            placeholder=" Car Model"
            required
            onChange={(e) => setModel(e.target.value)}
          />
          <input
            style={{ display: "none" }}
            id="pic"
            type="file"
            multiple
            accept=".jpg,.png,.gif"
            max="5"
            required
            onChange={(e) => setCarPictures(e.target.files[0])}
          />
          <div className="pic">
            <label htmlFor="pic">
              <img
                src="https://img.icons8.com/fluency-systems-regular/512/add_car.png"
                alt=""
              />
              <span> Add Car Images</span>
              <p>{carPictures && carPictures.name}</p>
            </label>
          </div>
          <div className="divided">
            <input
              type="text"
              placeholder="Fuel Type"
              required
              onChange={(e) => setFuelType(e.target.value)}
            />
            <input
              required
              type="text"
              placeholder="Year of manufacture"
              pattern="[0-9]{4}"
              maxLength={4}
              onChange={(e) => setYear(e.target.value)}
            />
          </div>
          <div className="divided">
            <input
              type="text"
              placeholder="Transmission"
              required
              onChange={(e) => setTransmission(e.target.value)}
            />
            <input
              type="number"
              placeholder="Mileage"
              required
              onChange={(e) => {
                const priceString = Number(e.target.value).toLocaleString(
                  "en-US",
                  {
                    minimumFractionDigits: 0,
                    maximumFractionDigits: 0,
                  }
                );
                setMileage(priceString);
              }}
            />
          </div>

          <input
            required
            type="tel"
            placeholder="Enter phone number"
            pattern="[0-9]{10}"
            maxLength={10}
            onChange={(e) => setPhoneNumber(e.target.value)}
          />
          <input
            required
            type="number"
            min="0"
            max="30000000"
            placeholder="Price"
            onChange={(e) => {
              const priceString = Number(e.target.value).toLocaleString(
                "en-US",
                {
                  minimumFractionDigits: 0,
                  maximumFractionDigits: 0,
                }
              );
              setPrice(priceString);
            }}
          />

          <select
            name=""
            id="location"
            required
            onChange={(e) => setLocation(e.target.value)}
          >
            <option value="" disabled selected>
              Select your location:
            </option>
            <option value="Mombasa">Mombasa</option>
            <option value="Kwale">Kwale</option>
            <option value="Kilifi">Kilifi</option>
            <option value="Tana_river">Tana River</option>
            <option value="Lamu">Lamu</option>
            <option value="Taita Taveta">Taita-Taveta</option>
            <option value="Garissa">Garissa</option>
            <option value="Wajir">Wajir</option>
            <option value="Mandera">Mandera</option>
            <option value="Marsabit">Marsabit</option>
            <option value="Isiolo">Isiolo</option>
            <option value="Meru">Meru</option>
            <option value="Tharaka_nithi">Tharaka-Nithi</option>
            <option value="Embu">Embu</option>
            <option value="Kitui">Kitui</option>
            <option value="Machakos">Machakos</option>
            <option value="Makueni">Makueni</option>
            <option value="Nyandarua">Nyandarua</option>
            <option value="Nyeri">Nyeri</option>
            <option value="Kirinyaga">Kirinyaga</option>
            <option value="murang'a">Murang'a</option>
            <option value="Kiambu">Kiambu</option>
            <option value="Turkana">Turkana</option>
            <option value="West Pokot">West Pokot</option>
            <option value="Samburu">Samburu</option>
            <option value="Trans-nzoia">Trans-Nzoia</option>
            <option value="Uasin gishu">Uasin Gishu</option>
            <option value="Elgeyo-Marakwet">Elgeyo Marakwet</option>
            <option value="Nandi">Nandi</option>
            <option value="Baringo">Baringo</option>
            <option value="Laikipia">Laikipia</option>
            <option value="Nakuru">Nakuru</option>
            <option value="Narok">Narok</option>
            <option value="Kajiado">Kajiado</option>
            <option value="Kericho">Kericho</option>
            <option value="Bomet">Bomet</option>
            <option value="Kakamega">Kakamega</option>
            <option value="Vihiga">Vihiga</option>
            <option value="Bungoma">Bungoma</option>
            <option value="Busia">Busia</option>
            <option value="Siaya">Siaya</option>
            <option value="Kisumu">Kisumu</option>
            <option value="Hcomabay">Homa Bay</option>
            <option value="Migori">Migori</option>
            <option value="Kisii">Kisii</option>
            <option value="Nyamira">Nyamira</option>
            <option value="Nairobi">Nairobi</option>
          </select>
          {err && <p className="error-message">{err}</p>}
          <button type="submit">SELL</button>
          {loading && (
            <div className="loading">
              <div className="spinner"></div>
            </div>
          )}
        </form>
      </div>
    </div>
  );
}
