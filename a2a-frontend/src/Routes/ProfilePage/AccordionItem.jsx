//Packages
import React, {useState } from 'react'
import styled from 'styled-components'
import { CircularProgressbarWithChildren, buildStyles } from 'react-circular-progressbar';
import { Button} from '@material-ui/core';
import { Accordion, AccordionSummary, AccordionDetails } from '@material-ui/core';

//Source code 
import RadialSeparators from './RadialSeperators';
import QuestionComponent from './QuestionComponent'


//Component
function AccordionItem(props) {

    const [progress, setProgress] = useState(20);
    const [isEdit, setIsEdit] = useState(false);

    const handleSaveChanges = () => {
        setIsEdit(false)
    }
    
    const handleCancelChanges = () => {
        setIsEdit(false)
    }

    return (
        <StyledAccordion>
            <StyledAccordionSummary
                aria-controls="panel1a-content"
                id="panel1a-header"
            >
                <AccordionHeaderContainer>
                    <div>
                        <h3>Ethnicity, Religion</h3>
                    </div>
                    <ProgressContainer>
                        <CircularProgressbarWithChildren
                            value={80}
                            text={`${80}%`}
                            strokeWidth={10}
                            styles={buildStyles({
                                strokeLinecap: "butt",
                                pathColor: props.progressColor,
                            })}
                        >
                            <RadialSeparators
                                count={12}
                                style={{
                                    background: "#fff",
                                    width: "2px",
                                    // This needs to be equal to props.strokeWidth
                                    height: `${10}%`
                                }}
                            />
                        </CircularProgressbarWithChildren>
                    </ProgressContainer>
                </AccordionHeaderContainer>
                <AccordinonInfo>We asks questions about your Ethnicity and Religion. This is how compatibilty system finds your most compatible matches.</AccordinonInfo>
            </StyledAccordionSummary>
            <StyledAccordionDetails>

                {!isEdit ?
                    <div>
                        <HeightMargin>
                            <InnerDetailPadding>
                                <div className='text-right'>
                                    <EditButton onClick={() => setIsEdit(true)}>Edit</EditButton>
                                </div>
                                <FlexContainer>
                                    <QuestionComponent readOnly />
                                    <QuestionComponent readOnly />
                                    <QuestionComponent readOnly />
                                </FlexContainer>
                            </InnerDetailPadding>
                        </HeightMargin>
                    </div>
                    :
                    <div>
                        <HeightMargin>
                            <div>
                                <TempMarginTop>
                                    <InnerDetailPadding>
                                        <FlexContainer>
                                            <QuestionComponent shortQuestion={true} />
                                            <QuestionComponent shortQuestion={true} />
                                            <QuestionComponent longQuestion={true} />
                                            <QuestionComponent longQuestion={true} />
                                        </FlexContainer>

                                        <ChangeButtonsDiv>
                                            <ChangeButton bgColor="pink" onClick={() => handleSaveChanges()}>Save</ChangeButton>
                                            <ChangeButton bgColor="white" onClick={() => handleCancelChanges()}>Cancel</ChangeButton>
                                        </ChangeButtonsDiv>
                                    </InnerDetailPadding>
                                </TempMarginTop>
                            </div>
                            <div>
                                <TempMarginTop>
                                    <InnerDetailPadding>
                                        <FlexContainer>
                                            <QuestionComponent notAdded={true} />
                                            <QuestionComponent notAdded={true} />
                                            <QuestionComponent notAdded={true} />
                                            <QuestionComponent notAdded={true} />
                                        </FlexContainer>
                                    </InnerDetailPadding>
                                </TempMarginTop>
                            </div>
                        </HeightMargin>
                    </div>
                }

            </StyledAccordionDetails>
        </StyledAccordion>
    );
}

//Styling
const StyledAccordion = styled(Accordion)`
    margin-bottom: 20px;
    &.MuiAccordion-root:before{
        opacity: 0;
    }
    &.MuiAccordion-rounded:first-child, &.MuiAccordion-rounded:last-child{
        border-radius: 10px;
    }
    &.MuiAccordion-rounded{
        box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.25);
        border-radius: 10px;
    }
`;
const StyledAccordionSummary = styled(AccordionSummary)`
    .MuiAccordionSummary-content{
        justify-content: center;
        display: block;
    }
`;
const AccordionHeaderContainer = styled.div`
    display: flex;
    justify-content: space-between;
    align-items:center;
    div:first-child {
        flex-grow: 1;
    }
`;
const StyledAccordionDetails = styled(AccordionDetails)`
    &.MuiAccordionDetails-root{
        display: block;
    }
`;
const AccordinonInfo = styled.p`
    font-size: 0.85rem;
    padding: 0 5vw;
    margin-top: 0;
`;
const ProgressContainer = styled.div`
    width:45px;
    height:45px;
`;
const InnerDetailPadding = styled.div`
    padding: 0 3vw;
`;
const FlexContainer = styled.div`
    display: flex;
    flex-direction: column;
    gap: 3rem;
`;
const TempMarginTop = styled.div`
    margin-top: 3rem;
`;
const EditButton = styled(Button)`
    &:not(#ed #ac){
        background: #2684FF;
        border-radius: 10px;
        color: #FFFFFF;
    }
`;
const ChangeButton = styled(Button)`
    &:not(#ed #ac){
        min-width: 13vw;
        background: #2684FF;
        border-radius: 10px;
        color: ${props => props.bgColor === 'pink' ? "#FFFFFF" : "#F08599"};
        background-color: ${props => props.bgColor === 'pink' ? "#F08599" : "#FFFFFF"};
        border : ${props => props.bgColor === 'pink' ? "" : "2px solid #F08599"};
    }
`;
const HeightMargin = styled.div`
    margin-top: 1vh;
    margin-bottom: 6vh;
`;
const ChangeButtonsDiv = styled.div`
    display: flex;
    align-items: center;
    gap: 10px;
    justify-content: flex-end;
    margin-top: 1rem;
`;

export default AccordionItem;
