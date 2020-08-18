import { gql } from "@apollo/client";

export const LIST_TIMERS = gql`
  query ListTimers($matching: String, $elapsed: Int) {
    timers(
      filter: { matching: $matching, elapsed: $elapsed, status: "active" }
    ) {
      id
      title
      project
      # clock {
      #   isRunning
      #   elapsed
      # }
    }
  }
`;

export const GET_TIMER = gql`
  query GetTimer($id: ID!) {
    timer(id: $id) {
      id
      title
      project
      # clock {
      #   isRunning
      #   elapsed
      # }
    }
  }
`;
