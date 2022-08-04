//Packages
import { hexToRgb } from "@material-ui/core";
import React from "react";
import styled from "styled-components";
import { Link } from "react-router-dom";
//Assets
import Logo from "../assets/Logo512.png";

//Component
function ScreenContainer(props) {
  const styles = {
    backgroundColor: "#E5E5E5",
    
  };

  return (
    <MainPadding>
        <LogoAndName />      
      {props.children}
    </MainPadding>
  );
}

function LogoAndName() {
  return (
    <div>
      <table>
        <tr>
          <td>
          <Link to="/" style={{textDecoration: 'none' , color: '#000000'}}><AppLogo src={Logo} alt="Aunties + Algorithms Logo" /> </Link>{" "}
          </td>
          <td>
          <Link to="/" style={{textDecoration: 'none' , color: '#000000'}}><AuntiesAlgorithms> Aunties + Algorithms</AuntiesAlgorithms> </Link>
          </td>
        </tr>
      </table>
    </div>
  );
}

//Styled Components
const AppLogo = styled.img`
  height: 80px;
  width: 80px;
  padding: 30px;
`;

const AuntiesAlgorithms = styled.h1`
  font-size: 20px;
  text-align: left;
  font-family: "Fira Sans", sans-serif;
  font-style: light;
  color: #e8a3b0;
`;
const MainPadding = styled.div`
    padding: 1vh 10vw;
    background-color: #E5E5E5;
    height: 100vh;
`;

export default ScreenContainer;
