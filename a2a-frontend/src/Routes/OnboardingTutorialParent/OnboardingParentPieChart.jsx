//Packages
import styled from "styled-components";

//Source code
import Heading from "../../Components/Heading";

function OnboardingParentPieChart() {
  return (
    <>
      <Heading style={{ paddingBottom: "30px" }}>
        {" "}
        Prioritise the things that are the most important.{" "}
      </Heading>
      <GreyBg>
        <CenteredDiv>
          <p>Drags the piechart segments and the matches' </p>
          <p>rankings change on the side.</p>
        </CenteredDiv>
      </GreyBg>

      <CenteredDiv>
        <p>
          The match rankings change as you give weighted preference to each
          category.{" "}
        </p>
      </CenteredDiv>
    </>
  );
}

export default OnboardingParentPieChart;

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
