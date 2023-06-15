package org.example.appfx;

import javafx.application.*;
import javafx.scene.*;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.*;

public class HelloFX extends Application {
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("Hello JavaFX!");
        Button btn = new Button();
        btn.setText("Hello JavaFX!");
        btn.setOnAction( (event) -> Platform.exit() );
        Pane root = new StackPane();
        root.getChildren().add(btn);
        primaryStage.setScene(new Scene(root, 300, 150));
        primaryStage.show();
    }
}



/*
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

// Simple Hello World JavaFX program
public class Main extends Application {
    public static void main(String[] args) {
        launch(args);
    }

    // JavaFX entry point
    @Override
    public void start(Stage primaryStage) {
        String message = "Hello World!";
        Button btnHello = new Button();
        btnHello.setText(message);

        // A layout container for UI controls
        StackPane root = new StackPane();
        root.getChildren().add(btnHello);

        // Top level container for all view content
        Scene scene = new Scene(root, 300, 250);

        // primaryStage is the main top level window created by platform
        primaryStage.setTitle(message);
        primaryStage.setScene(scene);
        primaryStage.show();
    }
}*/