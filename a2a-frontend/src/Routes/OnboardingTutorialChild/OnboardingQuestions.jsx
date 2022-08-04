//Packages
import styled from "styled-components";

//Source Code 
import Heading from "../../Components/Heading";

function OnboardingQuestions() {
  return (
    <>
      <Heading>
        {" "}
        Find compatible matches without reveleaing all your info.{" "}
      </Heading>
      <GreyBg>
        <CenteredDiv>
          <p>Choose answers from multiple choice questions.</p>
          <p>Determines visible/Invisible</p>
        </CenteredDiv>
      </GreyBg>

      <CenteredDiv>
        <p>
          Answer to questions in different categories and choose to make them
          visible or invisible to your matches.{" "}
        </p>
        <p>
          The higher the completion rate, the better we can get you matched!{" "}
        </p>
      </CenteredDiv>
    </>
  );
}

export default OnboardingQuestions;

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
