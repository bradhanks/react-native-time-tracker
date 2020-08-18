import { gql } from "@apollo/client";

export const CREATE_TIMER = gql`
  mutation CreateTimer($project: String, $title: String) {
    createTimer(project: $project, title: $title, status: "active") {
      id
      title
      project
    }
  }
`;

export const UPDATE_TIMER = gql`
  mutation UpdateTimer($id: ID!, $project: String, $title: String) {
    updateTimer(id: $id, project: $project, title: $title) {
      id
      title
      project
      # clock {
      #   id
      #   isRunning
      #   elapsed
      # }
    }
  }
`;

export const DELETE_TIMER = gql`
  mutation DeleteTimer($id: ID!) {
    deleteTimer(id: $id) {
      id
      status
    }
  }
`;

export const HARD_DELETE_TIMER = gql`
  mutation HardDeleteTimer($id: ID!) {
    hardDeleteTimer(id: $id) {
      id
      title
      status
    }
  }
`;