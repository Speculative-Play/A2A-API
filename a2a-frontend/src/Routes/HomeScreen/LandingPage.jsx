//Packages
import { Button, Box } from '@material-ui/core';
import React from 'react'
import styled from 'styled-components'
import { Link } from 'react-router-dom';

//Source code 
import ScreenContainer from '../../Components/ScreenContainer';
import Heading from "../../Components/Heading";
//Component
export default function LandingPage(props){
    return (
        <ScreenContainer >
            <Heading>First Page Animation/GIF Message</Heading>
            
            <CenteredDiv>
                <p>Pie Chart: Giving weighted preference to different blocks.</p>
                <p>Explore how to have different amount of personal agency.</p>
            </CenteredDiv>
            
            <CenteredDiv>
                <p>Addressing User's Pain Points: Mitigating the tension between the wants of Children vs Parents vs Society.</p>
            </CenteredDiv>
            
            <CenteredDiv>
                <p>Similar stuff like other websites, just the way you choose to work with them is different (we are not radical)</p>
            </CenteredDiv>

            <CenteredDiv>
                <p>Privacy and Visibility Options</p>
                <p>Who you are and how you wish to be represented</p>
            </CenteredDiv>

            <CallToActionText>Start Free Today! SIGN UP</CallToActionText>
            
            <Box display="flex" justifyContent="center" alignItems="center" sx={{m:3}}>
            <Link to="/onboarding" style={{textDecoration: 'none' , color: '#000000'}}><Button variant="contained" >I'm a User looking for a match</Button></Link>
            </Box>

            <Box display="flex" justifyContent="center" alignItems="center">
                <Button variant="contained" > <Link to="/onboarding-parent" style={{textDecoration: 'none' , color: '#000000'}}>I'm a Parent helping my child find a match </Link> </Button>
            </Box>

            <CenteredP>Already have an account? <Link to='/auth' style={{textDecoration: 'none'}}>Log In</Link> </CenteredP>
        </ScreenContainer>
    );
}



//Styling


const CenteredDiv = styled.div`
font-size: 14px;
text-align: center;
font-family: 'Fira Sans', sans-serif;
font-style: light;
color: #676767D9;
padding-top: 1px;
flex-wrap: wrap;
`;

const CallToActionText = styled.h2`
color = #000;
font-size: 20px;
text-align: center;
font-family: 'Fira Sans', sans-serif;
padding-top: 10px;
`;

const CenteredP = styled.p`
text-align: center;
color: #0000000;
font-family: 'Fira Sans', sans-serif;
font-size: 12px;
`;
