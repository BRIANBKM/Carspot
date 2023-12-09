import React from "react";
import HomeBrands from "../brands";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Topdeals from "../../Cars/topdeals";
import Audi from "../../Cars/audi";
import Bentley from "../../Cars/bentley";
import BMW from "../../Cars/bmw";
import Chevrolet from "../../Cars/chevrolet";
import Ford from "../../Cars/ford";
import GMC from "../../Cars/gmc";
import Honda from "../../Cars/honda";
import Hyundai from "../../Cars/hyundai";
import Isuzu from "../../Cars/isuzu";
import Jaguar from "../../Cars/jaguar";
import Jeep from "../../Cars/jeep";
import MAZDA from "../../Cars/mazda";
import Land_Rover from "../../Cars/land_rover";
import Lexus from "../../Cars/lexus";
import Mercedes_benz from "../../Cars/mercedes_benz";
import Mistubishi from "../../Cars/mistubishi";
import Suzuki from "../../Cars/suzuki";
import Nissan from "../../Cars/nissan";
import Porche from "../../Cars/porche";
import Proton from "../../Cars/proton";
import Renault from "../../Cars/renault";
import Roll_royce from "../../Cars/roll_royce";
import Subaru from "../../Cars/subaru";
import Toyota from "../../Cars/toyota";
import Volkswagen from "../../Cars/volkswagen";
import Volvo from "../../Cars/volvo";
import Peugeot from "../../Cars/peugeot";

function Home() {
  return (
    <div className="homeItems">
      <Router>
        <HomeBrands />
        <div className="cars">
          <Switch>
            <Route path="/" exact component={Topdeals} />
            <Route path="/audi" component={Audi} />
            <Route path="/bentley" component={Bentley} />
            <Route path="/bmw" component={BMW} />
            <Route path="/chevrolet" component={Chevrolet} />
            <Route path="/ford" component={Ford} />
            <Route path="/gmc" component={GMC} />
            <Route path="/honda" component={Honda} />
            <Route path="/hyundai" component={Hyundai} />
            <Route path="/isuzu" component={Isuzu} />
            <Route path="/jaguar" component={Jaguar} />
            <Route path="/jeep" component={Jeep} />
            <Route path="/landrover" component={Land_Rover} />
            <Route path="/lexus" component={Lexus} />
            <Route path="/mazda" component={MAZDA} />
            <Route path="/mercedesbenz" component={Mercedes_benz} />
            <Route path="/mistubishi" component={Mistubishi} />
            <Route path="/nissan" component={Nissan} />
            <Route path="/porche" component={Porche} />
            <Route path="/peugeot" component={Peugeot} />
            <Route path="/proton" component={Proton} />
            <Route path="/renault" component={Renault} />
            <Route path="/rollroyce" component={Roll_royce} />
            <Route path="/subaru" component={Subaru} />
            <Route path="/suzuki" component={Suzuki} />
            <Route path="/toyota" component={Toyota} />
            <Route path="/volkswagen" component={Volkswagen} />
            <Route path="/volvo" component={Volvo} />
          </Switch>
        </div>
      </Router>
    </div>
  );
}

export default Home;
