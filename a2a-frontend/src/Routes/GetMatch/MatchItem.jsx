//Packages
import React, { Component } from 'react'
import styled from 'styled-components'
import { Button} from '@material-ui/core';

//Component
function MatchItem(props) {


  return (
    <ParentDiv>
      <CardContainer>
        <CardNumber>
          1
        </CardNumber>
        <CardContentWrapper>
          <CardImageContainer>
            <img src="/images/sample_user_male.png" alt="" />
          </CardImageContainer>
          <CardInfo>
            <PersonName>
              Ikshit Singh
            </PersonName>
            <div>
              <PersonInfoText>30 Years Old</PersonInfoText>
              <PersonInfoText>Delhi, India</PersonInfoText>
            </div>
            <PinkButtonWrapper>
              <Button>
                See Profile
              </Button>
            </PinkButtonWrapper>
          </CardInfo>
        </CardContentWrapper>
      </CardContainer>
    </ParentDiv>
  );
}

//Styling
const ParentDiv = styled.div`
  background-color: white;
  border-radius: 10px;
`;
const CardNumber = styled.div`
  text-align: center;
  font-size: 26px;
  padding: 0 10px;
  color: rgba(103, 103, 103, 0.85);
  padding-left: 2.5vw;
`;
const CardContainer = styled.div`
  display: flex;
  align-items: center;
  gap: 8px;
`;
const CardContentWrapper = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-around;
  padding: 1.5vh 0;
  flex-grow: 1;
  background: #FFFFFF;
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.25);
  border-radius: 10px;
`;
const CardImageContainer = styled.div`
  max-width: 64px;
  img{
    width: 100%;
    border-radius: 10px;
  }
`;
const CardInfo = styled.div`
  display: flex;
  flex-direction: column;
  gap: 5px;
`;
const PersonName = styled.div`
  font-family: 'Fira Sans';
  font-style: normal;
  font-weight: 500;
  font-size: 12px;
`;
const PersonInfoText = styled.div`
  font-family: 'Fira Sans';
  font-style: normal;
  font-weight: 400;
  font-size: 7px;
`;
const PinkButtonWrapper = styled.div`
  button {
  font-family: 'Fira Sans';
  font-style: normal;
  font-weight: 500;
  font-size: 8px;
  color: #FFFFFF;
  background-color: #F08599;
  border-radius: 5px;
  }
`;

export default MatchItem;
