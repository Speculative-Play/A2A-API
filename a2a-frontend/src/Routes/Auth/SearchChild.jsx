//Packages
import styled from "styled-components";
import { Button, TextField } from "@material-ui/core";
import { Link } from "react-router-dom";

//Source Code
import ScreenContainer from "../../Components/ScreenContainer";
import WhiteBG from "../../Components/WhiteBG";
import Heading from "../../Components/Heading";
import PinkButton from "../../Components/PinkButton";
function SearchChild() {
  return (
    <ScreenContainer>
      <WhiteBG>
        <Heading>
          {" "}
          Select one of the following options to find your child{" "}
        </Heading>

        <TextField
          label="Your child's name"
          placeholder="Enter your child's name"
          fullWidth
          margin="normal"
          InputLabelProps={{
            shrink: true,
          }}
          style={{ paddingBottom: "10px" }}
          variant="outlined"
        />

        <TextField
          type="email"
          label="Their Email Address"
          placeholder="example@domain.com"
          fullWidth
          margin="normal"
          InputLabelProps={{
            shrink: true,
          }}
          style={{ paddingBottom: "10px" }}
          variant="outlined"
        />

        <TextField
          type="phone"
          label="Their Phone Number"
          placeholder="+1 234 567 8899"
          fullWidth
          margin="normal"
          InputLabelProps={{
            shrink: true,
          }}
          style={{ paddingBottom: "10px" }}
          variant="outlined"
        />

          <Link
            className="curson-pointer"
            to="/profile-not-found"
            style={{ textDecoration: "none" }}
          >
            <PinkButton>Search</PinkButton>
          </Link>

      </WhiteBG>
    </ScreenContainer>
  );
}

export default SearchChild;
