//Packages
import styled from "styled-components";
import { useState, useEffect } from "react";
import { Button } from "@material-ui/core";
import { Navigate } from "react-router-dom";

//Source Code
import ScreenContainer from "../../Components/ScreenContainer";
import ProgressBar from "../../Components/ProgressBar";
import WhiteBG from "../../Components/WhiteBG";
import PinkButton from "../../Components/PinkButton";

import OnboardingBiodata from "./OnboardingBiodata";
import OnboardingParentPieChart from "./OnboardingParentPieChart";
import OnboardingStarProfile from "./OnboardingStarProfile";

function ParentOnboarding() {
  const [onboardingParentProgress, setOnboardParentingProgress] = useState(33);

  useEffect(NextPage, [onboardingParentProgress]);

  function NextPage() {
    if (onboardingParentProgress === 33) {
      return <OnboardingBiodata />;
    } else if (onboardingParentProgress === 66) {
      return <OnboardingParentPieChart />;
    } else if (onboardingParentProgress === 99) {
      return <OnboardingStarProfile />;
    }
    return <Navigate to="/search-child" />;
  }

  return (
    <ScreenContainer>
      <WhiteBG>
        <ProgressBar completed={onboardingParentProgress}></ProgressBar>

        <NextPage />

        <PinkButton
          id="nextButton"
          onClick={() =>
            setOnboardParentingProgress(
              Math.max(0, (onboardingParentProgress + 33) % 132)
            )
          }
        >
          {onboardingParentProgress === 99 ? "Find profile" : "Next"}
        </PinkButton>
      </WhiteBG>
    </ScreenContainer>
  );
}

export default ParentOnboarding;
