//Packages
import styled from "styled-components";
import { Link } from "react-router-dom";
//Source Code
import ScreenContainer from "../../Components/ScreenContainer";
import Heading from "../../Components/Heading";
import WhiteBG from "../../Components/WhiteBG";
import PinkButton from "../../Components/PinkButton";


function ProfileNotFound() {
  return (
    <ScreenContainer>
      <WhiteBG>
        <Heading style={{ paddingBottom: "60px" }}>
          Sorry! We couldn't find any profile with this information.
        </Heading>
        <Link to="/search-child" style={{ textDecoration: "none" }}>
          <PinkButton>Try Other Ways</PinkButton>
        </Link>
      </WhiteBG>
    </ScreenContainer>
  );
}

export default ProfileNotFound;

//Styled Components
