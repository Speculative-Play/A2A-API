// Packages
import styled from "styled-components";
import { Button } from "@material-ui/core";
function PinkButton(props) {
    return (
        <ButtonsContainer>
            <StyledButton id= {props.id} onClick={props.onClick}>{props.children}</StyledButton>
        </ButtonsContainer>
    );
}

export default PinkButton;
const StyledButton = styled(Button)`
  &:not(#au #ca) {
    background: ${(props) => (props.contrast ? "#fff" : "#E8A3B0")};
    border-radius: 5px;
    color: ${(props) => (props.contrast ? "#E8A3B0" : "#fff")};
    min-width: 300px;
    height: 45px;
    border: ${(props) => (props.contrast ? "1px solid #E8A3B0" : "unset")};
  }
`;

const ButtonsContainer = styled.div`
  display: flex;
  gap: 1.4rem;
  justify-content: center;
`;
