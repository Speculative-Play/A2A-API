//Packages
import styled from "styled-components";

//Source Code 
import Heading from "../../Components/Heading";


function OnboardingMatchProfiles() {
  return (
    <>
      <Heading>
        {" "}
        See your match profiles and chat with them!{" "}
      </Heading>
      <GreyBg>
        <CenteredDiv>
          <p>Clicks on a profile from the list</p>
          <p>Texting each other in the chat box and sending heart emojies</p>
        </CenteredDiv>
      </GreyBg>

      <CenteredDiv>
        <p>
          Once you checked your potential matches profile you{" "}
        </p>
        <p>
          can chat with them and know more about each other!{" "}
        </p>
      </CenteredDiv>
    </>
  );
}

export default OnboardingMatchProfiles;

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
