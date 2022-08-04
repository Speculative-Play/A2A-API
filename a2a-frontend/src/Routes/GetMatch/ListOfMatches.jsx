//Packages
import React, {Component} from 'react'
import styled from 'styled-components'
import {Grid } from '@material-ui/core';

//Source Code
import MatchItem from './MatchItem';

//Component
function GetMatchPage(props) {

  const sampleMatch = () =>  <>
    <Grid item xs={12}>
      <MatchItem />
    </Grid>
  </>

  return (
    <div>
        <ListContainerStyle>
          <Grid container spacing={2} direction="column">
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
            {sampleMatch()}
          </Grid>
        </ListContainerStyle>
    </div>
  );
}

//Styling
const ListContainerStyle = styled.div`
  background-color: rgba(245, 234, 234, 0.35);
  border-radius: 17px;
  padding: 25px;
`;

export default GetMatchPage;
