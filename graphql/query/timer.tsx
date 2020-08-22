import { gql } from "@apollo/client";

export const LIST_TIMERS = gql`
  query ListTimers($matching: String, $elapsed: Int, $status: String!) {
    timers(
      filter: { matching: $matching, elapsed: $elapsed, status: $status }
    ) {
      id
      title
      project
      status
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
      status
      # clock {
      #   isRunning
      #   elapsed
      # }
    }
  }
`;
