import { useMutation } from "@apollo/client";
import React, { useState } from "react";
import { StyleSheet, Text, TextInput, View, Alert } from "react-native";
import { LIST_TIMERS } from "../graphql/query/timer";
import { CREATE_TIMER } from "../graphql/mutation/timer";
import { TimerButton } from "./TimerButton";

// interface AllProp {
//   id: string;
//   title: string;
//   project: string;
//   onCancel: () => void;
// }

export default function NewTimerForm({ onCreatePress, onCancel }): JSX.Element {
  //logic for submit button

  // React hooks
  const [timerFormTitle, setTimerFormTitle] = useState(" ");
  const [timerFormProject, setTimerFormProject] = useState(" ");

  const mutationVars = {
    project: timerFormProject,
    title: timerFormTitle,
    status: "active",
  };

  // Apollo hook
  const [createTimer] = useMutation(CREATE_TIMER, {
    variables: mutationVars,
    update: (cache, { data }) => {
      return cache.writeQuery({
        query: LIST_TIMERS,
        variables: {status: "active"},
        data: {
          timers: [
            ...cache.readQuery({ query: LIST_TIMERS, variables : {status: "active"} })!.timers,
            data!.createTimer,
          ],
        },
      });
    },
  });

  // validation
  const Validate = {
    minimum:
    function (hookVariable, count) {
    if (hookVariable.length < count) {
        Alert.alert('Alert', `${hookVariable} must be minimum ${count} characters`);
    }
    //Do your stuff if condition meet.
  },
};

  return (
    <View style={styles.formContainer}>
      <View style={styles.attributeContainer}>
        <Text style={styles.textInputTitle}>Title</Text>
        <View style={styles.textInputContainer}>
          <TextInput
            style={styles.textInput}
            underlineColorAndroid="transparent"
            autoFocus={true}
            defaultValue={timerFormTitle}
            onChangeText={(text) => setTimerFormTitle(text)}
          />
        </View>
      </View>
      <View style={styles.attributeContainer}>
        <Text style={styles.textInputTitle}>Project</Text>
        <View style={styles.textInputContainer}>
          <TextInput
            style={styles.textInput}
            underlineColorAndroid={"transparent"}
            defaultValue={timerFormProject}
            onChangeText={(text) => setTimerFormProject(text)}
          />
        </View>
      </View>
      <View style={styles.buttonGroup}>
        <TimerButton
          small
          color="#21BA45"
          title="Submit"
          onPress={() => {
            createTimer();
            Validate.minimum(timerFormTitle, 8);
            //   {
            //   variables: mutationVars,
            //   update: (cache, { data }) => {
            //     return cache.writeQuery({
            //       query: LIST_TIMERS,
            //       data: {
            //         timers: [
            //           ...cache.readQuery({ query: LIST_TIMERS, variables : {status: "active"} })!.timers,
            //           data!.createTimer,
            //         ],
            //       },
            //     });
            //   }});
            // //setTimerFormTitle("");
            // //setTimerFormProject("");
            onCreatePress();
          }}
        />
        <TimerButton small color="#DB2828" title="Cancel" onPress={onCancel} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  formContainer: {
    backgroundColor: "white",
    borderColor: "#D6D7DA",
    borderWidth: 2,
    borderRadius: 10,
    padding: 15,
    margin: 15,
    marginBottom: 0,
  },
  attributeContainer: {
    marginVertical: 8,
  },
  textInputContainer: {
    borderColor: "#D6D7DA",
    borderRadius: 2,
    borderWidth: 1,
    marginBottom: 5,
  },
  textInput: {
    height: 30,
    padding: 5,
    fontSize: 12,
  },
  textInputTitle: {
    fontSize: 14,
    fontWeight: "bold",
    marginBottom: 5,
  },
  buttonGroup: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
});
