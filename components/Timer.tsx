import { useMutation } from "@apollo/client";
import React from "react";
import { StyleSheet, Text, View } from "react-native";
import { DELETE_TIMER, LIST_TIMERS } from "../graphql/timerQueries";
import { TimerButton } from "./TimerButton";

export const Timer = ({
  id,
  title,
  project,
  //elapsed,
  onEditPress,
  // isRunning,
}) => {
  //const elapsedString = millisecondsToHuman(elapsed);
  const [deleteTimer, { data }] = useMutation(DELETE_TIMER, {
    variables: { id: id },
    update(cache) {
      const { timers } = cache.readQuery({
        query: LIST_TIMERS,
      });
      cache.writeQuery({
        query: LIST_TIMERS,
        data: {
          timers: timers.filter((timer) => timer.status == "active"),
        },
      });
    },
  });

  return (
    <View style={styles.timerContainer}>
      <Text style={styles.title}>{title}</Text>
      <Text>{project}</Text>
      <Text style={styles.elapsedTime}>0</Text>
      <View style={styles.buttonGroup}>
        <TimerButton onPress={onEditPress} color="blue" small title="Edit" />

        <TimerButton onPress={deleteTimer} color="blue" small title="Remove" />
      </View>
      <TimerButton
        onPress={onEditPress}
        small={false}
        color="#21BA45"
        title="Start"
      />
    </View>
  );
};

const styles = StyleSheet.create({
  timerContainer: {
    backgroundColor: "white",
    borderColor: "#d6d7da",
    borderWidth: 2,
    borderRadius: 10,
    padding: 15,
    margin: 15,
    marginBottom: 0,
  },
  title: {
    fontSize: 14,
    fontWeight: "bold",
  },
  elapsedTime: {
    fontSize: 26,
    fontWeight: "bold",
    textAlign: "center",
    paddingVertical: 15,
  },
  buttonGroup: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
});
