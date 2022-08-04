//Packages
import styled from "styled-components";

//Source Code 
import Heading from "../../Components/Heading";

function OnboardingStarProfile() {
  return (
    <>
      <Heading> Star the good matches </Heading>
      <GreyBg>
        <CenteredDiv>
          <p style={{padding: "70px"}}>Click the Star sign in the Biodata page of the match profile</p>
        </CenteredDiv>
      </GreyBg>

      <CenteredDiv>
        <p>Let your child know who you find a suitable potential match by starring their profile.</p>
      </CenteredDiv>
    </>
  );
}

export default OnboardingStarProfile;

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
