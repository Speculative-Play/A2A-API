//Packages
import React from "react";
import {BrowserRouter as Router , Routes, Route} from 'react-router-dom';

//Source files
import AuthPage from './Auth/LoginPage';
import GetMatchPage from './GetMatch/GetMatchPage';
import ProfilePage from './ProfilePage/ProfilePage';
import LandingPage from './HomeScreen/LandingPage';
import CreateAccount from "./Auth/CreateAccount";
import ChildOnboarding from "./OnboardingTutorialChild/ChildOnboarding";
import ParentOnboarding from "./OnboardingTutorialParent/ParentOnboarding";
import SearchChild from "./Auth/SearchChild";
import ProfileNotFound from "./Auth/ProfileNotFound";

//Component
function PageRoutes(props){
    return <div>
      <Router>
        <Routes>
          <Route path='/' exact element={<LandingPage />} />
          <Route path='/profile' exact element={<ProfilePage />} />
          <Route path='/auth' exact element={<AuthPage />} />
          <Route path='/create-account' exact element={<CreateAccount />} /> 
          <Route path='/get-match' exact element={<GetMatchPage />} />
          <Route path='/onboarding' exact element={<ChildOnboarding />} /> 
          <Route path='/onboarding-parent' exact element={<ParentOnboarding />} /> 
          <Route path='/search-child' exact element={<SearchChild />} />
          <Route path='/profile-not-found' exact element={<ProfileNotFound />}/>
        </Routes> 
      </Router>
    </div>
}

export default PageRoutes;