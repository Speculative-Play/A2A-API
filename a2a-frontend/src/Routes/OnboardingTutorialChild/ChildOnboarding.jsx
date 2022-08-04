//Packages
import styled from "styled-components";
import { useState, useEffect } from "react";
import { Button } from "@material-ui/core";
import { Navigate } from "react-router-dom";
//Source Code
import ScreenContainer from "../../Components/ScreenContainer";
import ProgressBar from "../../Components/ProgressBar";
import PinkButton from "../../Components/PinkButton";
import WhiteBG from "../../Components/WhiteBG";

import OnboardingQuestions from "./OnboardingQuestions";
import OnboardingPieChart from "./OnboardingPieChart";
import OnboardingMatchProfiles from "./OnboardingMatchprofiles";
import OnboardingAddParents from "./OnboardingAddParents";

function ChildOnboarding() {
  const [onboardingProgress, setOnboardingProgress] = useState(25);
  useEffect(NextPage, [onboardingProgress]);

  function NextPage() {
    if (onboardingProgress === 25) {
      return <OnboardingQuestions />;
    } else if (onboardingProgress === 50) {
      return <OnboardingPieChart />;
    } else if (onboardingProgress === 75) {
      return <OnboardingMatchProfiles />;
    } else if (onboardingProgress == 100) {
      return <OnboardingAddParents />;
    }
    return <Navigate to="/create-account" />;
  }

  return (
    <ScreenContainer>
      <WhiteBG>
        <ProgressBar completed={onboardingProgress}></ProgressBar>

        <NextPage />

          <PinkButton
            id="nextButton"
            onClick={() =>
              setOnboardingProgress(
                Math.max(0, (onboardingProgress + 25) % 125)
              )
            }
          >
            {onboardingProgress === 100 ? "Signup" : "Next"}
          </PinkButton>
      </WhiteBG>
    </ScreenContainer>
  );
}

export default ChildOnboarding;
