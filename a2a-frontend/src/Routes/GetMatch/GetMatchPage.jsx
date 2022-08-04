//Packages
import React from 'react'
import styled from 'styled-components'
import { Button, Grid, FormGroup } from '@material-ui/core';

//SourceCode
import ListOfMatches from './ListOfMatches';
import draggablepiechart from '../../VanillaJS/PieChart';
import PieChartDisplayer from './PieChartDisplayer';

//Component
function GetMatchPage(props) {

  return (
    <div>
      <TemporaryPadding>
        <div>
          <StyledFormGroup row id='categories-container'>
          </StyledFormGroup> 
        </div>
        <Grid container spacing={4}>
          <Grid item xs={12} sm={8}>
            <ListContainerStyle>
              <PieChartDisplayer />
            </ListContainerStyle>

            <QuestionsContainer>
              <ListContainerStyle>
                <div>Do you want to have more ways to match?</div>
                <div>Click here to fill out more details about your astrological information.</div>
                <div>
                  <QuestionsButton>Go to Questions</QuestionsButton>
                </div>
              </ListContainerStyle>
              <ListContainerStyle>
                <div>Do you want to have more ways to match?</div>
                <div>Click here to fill out more details about your astrological information.</div>
                <div>
                  <QuestionsButton>Go to Questions</QuestionsButton>
                </div>
              </ListContainerStyle>
            </QuestionsContainer>

          </Grid>
          <Grid item xs={12} sm={4}>
            <ListOfMatches />
          </Grid>
        </Grid>
      </TemporaryPadding>
    </div>
  );
}

//Styling 
const TemporaryPadding = styled.div`
  padding: 5% 10vw;
`;
const ListContainerStyle = styled.div`
  background-color: rgba(245, 234, 234, 0.35);
  border-radius: 17px;
  padding: 25px;
`;
const QuestionsContainer = styled.div`
  margin-top:2rem;
  display: flex;
  gap: 20px;
  align-items: center;
  div{
    flex-grow:1;
  }
`;
const QuestionsButton = styled(Button)`
  &:not(#bt #gt){
    background: #E8A3B0;
    border-radius: 14px;
    margin-top: 1rem;
    color: #fff;
    padding: 0.5rem 1rem;
  }
`;


const StyledFormGroup = styled(FormGroup)`
  gap: 30px;
  margin-bottom: 3rem;
`;

export default GetMatchPage;
