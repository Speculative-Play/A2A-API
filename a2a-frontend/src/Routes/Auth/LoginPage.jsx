//Packages
import React, { useState } from "react";
import { Link } from "react-router-dom";
import styled from "styled-components";
import { Button, TextField } from "@material-ui/core";

//Source Code
import CreateAccount from "./CreateAccount";
import PinkButton from "../../Components/PinkButton";
import WhiteBG from "../../Components/WhiteBG";
import ScreenContainer from "../../Components/ScreenContainer";

//Component
function AuthPage(props) {
  const [isLogin, setIsLogin] = useState(true);
  const [form, setForm] = React.useState({
    email: "",
    password: "",
  });

  const handleChange = (option) => (event) => {
    setForm({ ...form, [option]: event.target.value });
  };

  const handleLogin = () => {
    //Perform authorization operations here
    //Send to database here
    console.log("handle login");
  };

  return (
    <ScreenContainer>
      <WhiteBG>
        {isLogin ? (
          <>
            <h2 style={{ align: "center" }}>Log in to your account</h2>

            <FormMarginBottom>
              <TextField
                onChange={handleChange("email")}
                type="email"
                id="outlined-full-width-email"
                label="Email Address"
                placeholder="Enter Your Email"
                fullWidth
                margin="normal"
                InputLabelProps={{
                  shrink: true,
                }}
                variant="outlined"
              />

              <TextField
                onChange={handleChange("password")}
                type="password"
                id="outlined-full-width-pass"
                label="Password"
                placeholder="Enter Your Password"
                fullWidth
                margin="normal"
                InputLabelProps={{
                  shrink: true,
                }}
                variant="outlined"
              />
            </FormMarginBottom>

              <PinkButton onClick={handleLogin}>Login</PinkButton>
            <LoginCallToAction className="cursor-pointer">
              <Link
                onClick={() => props.setIsLogin(false)}
                to="/create-account"
                style={{ textDecoration: "none" }}
              >
                Create an Account
              </Link>
            </LoginCallToAction>
          </>
        ) : (
          <>
            <CreateAccount setIsLogin={setIsLogin} />
          </>
        )}
      </WhiteBG>
    </ScreenContainer>
  );
}

//Styling

const FormMarginBottom = styled.div`
  margin-bottom: 3vh;
`;

const LoginCallToAction = styled.div`
  margin-top: 0.5rem;
  font-size: 14px;
  span {
    color: #e8a3b0;
    font-weight: bold;
  }
`;

export default AuthPage;
