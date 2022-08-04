//Packages
import styled from "styled-components";

//Source Code
import Heading from "../../Components/Heading";
function OnboardingBiodata() {
  return (
    <>
      <Heading style={{ paddingBottom: "30px" }}>
        {" "}
        We offer a new approach for helping your child find a life partner
      </Heading>
      <GreyBg>
        <CenteredDiv>
          <p style={{ paddingTop: "30px" }}>
            Autotype text animation in Biodata page converts to different
            categories
          </p>
        </CenteredDiv>
      </GreyBg>

      <CenteredDiv>
        <p>Your child has already filled out their information and </p>
        <p>we made them into categories.</p>
      </CenteredDiv>
    </>
  );
}

export default OnboardingBiodata;

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
  height: 100px;
`;
