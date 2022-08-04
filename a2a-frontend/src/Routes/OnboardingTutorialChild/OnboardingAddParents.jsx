//Packages
import styled from "styled-components";

//Source Code 
import Heading from "../../Components/Heading";

function OnboardingAddParents() {
  return (
    <>
      <Heading>
        {" "}
        Ask your parents to help you find a match if you want! :D{" "}
      </Heading>
      <GreyBg>
        <CenteredDiv>
          <p>Opens the parents section from the menu and </p>
          <p>see the list of starred profiles.</p>
        </CenteredDiv>
      </GreyBg>

      <CenteredDiv>
       <p>You can add a parents account to your profile so they can play with the pie chart </p> 
       <p>and see some biodata info to help you find a match and star their favourite profiles for you to see! </p>
      </CenteredDiv>
    </>
  );
}

export default OnboardingAddParents;

//Styled Components
const CenteredDiv = styled.div`
  font-size: 14px;
  text-align: center;
  font-family: "Fira Sans", sans-serif;
  font-style: light;
  color: #000000;
  padding-top: 1px;
  flex-wrap: wrap;
`;

const GreyBg = styled.div`
  background-color: #f5eaea;
  padding: 1vh 1vw;
  border-radius: 10px;
`;
