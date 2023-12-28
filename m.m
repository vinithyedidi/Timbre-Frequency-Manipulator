classdef m < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        FrequencyTimbreManipulatorv10UIFigure  matlab.ui.Figure
        GridLayout               matlab.ui.container.GridLayout
        LeftPanel                matlab.ui.container.Panel
        byVinithYedidiLabel      matlab.ui.control.Label
        FrequencyTimbreManipulatorv10Label  matlab.ui.control.Label
        Harmonics110normalizedto1Clickresetfordefault1nnLabel  matlab.ui.control.Label
        Label_10                 matlab.ui.control.Label
        Knob_10                  matlab.ui.control.Knob
        Label_9                  matlab.ui.control.Label
        Knob_9                   matlab.ui.control.Knob
        Label_8                  matlab.ui.control.Label
        Knob_8                   matlab.ui.control.Knob
        Label_7                  matlab.ui.control.Label
        Knob_7                   matlab.ui.control.Knob
        Label_6                  matlab.ui.control.Label
        Knob_6                   matlab.ui.control.Knob
        Label_5                  matlab.ui.control.Label
        Knob_5                   matlab.ui.control.Knob
        Label_4                  matlab.ui.control.Label
        Knob_4                   matlab.ui.control.Knob
        Label_3                  matlab.ui.control.Label
        Knob_3                   matlab.ui.control.Knob
        Label_2                  matlab.ui.control.Label
        Knob_2                   matlab.ui.control.Knob
        Label                    matlab.ui.control.Label
        Knob                     matlab.ui.control.Knob
        resetButton              matlab.ui.control.Button
        TimbreLabel              matlab.ui.control.Label
        FrequencyEditField       matlab.ui.control.NumericEditField
        FrequencyEditFieldLabel  matlab.ui.control.Label
        InputdesiredfrequencyandclickSubmittoseegraphsofthewaveLabel  matlab.ui.control.Label
        StopButton               matlab.ui.control.Button
        SubmitButton             matlab.ui.control.Button
        RightPanel               matlab.ui.container.Panel
        UIAxes2                  matlab.ui.control.UIAxes
        UIAxes                   matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function LeftPanelButtonDown(app, event)
            
        end

        % Button pushed function: SubmitButton
        function submit(app, event)

            plot(app.UIAxes, 0, 0);
            plot(app.UIAxes2, 0, 0);

            freq = app.FrequencyEditField.Value;
            app.StopButton.Enable = "on";
            app.SubmitButton.Enable = "off";
            app.FrequencyEditField.Enable = "off";
            app.Knob.Enable = "off";
            app.Knob_2.Enable = "off";
            app.Knob_3.Enable = "off";
            app.Knob_4.Enable = "off";
            app.Knob_5.Enable = "off";
            app.Knob_6.Enable = "off";
            app.Knob_7.Enable = "off";
            app.Knob_8.Enable = "off";
            app.Knob_9.Enable = "off";
            app.Knob_10.Enable = "off";

            
            dur = 10;
            fs = 44000; % app is programmed to sample at 44k HZ,
            num = 10;    % with 10 harmonics for 10 secs. The inputted
            timbre = zeros(1,num); %values for the harmonics are put into
            timbre(1) = app.Knob.Value;  %the timbre vector.
            timbre(2) = app.Knob_2.Value;
            timbre(3) = app.Knob_3.Value;
            timbre(4) = app.Knob_4.Value;
            timbre(5) = app.Knob_5.Value;
            timbre(6) = app.Knob_6.Value;
            timbre(7) = app.Knob_7.Value;
            timbre(8) = app.Knob_8.Value;
            timbre(9) = app.Knob_9.Value;
            timbre(10) = app.Knob_10.Value;
            disp(timbre);
            harmonics = generateHarmonics(freq,num,timbre,fs,dur);

            t = (0 : (1/fs) : (2/freq))';
            t(end) = [];

            % graph for sine wave and first 5 harmonics
            title(app.UIAxes, "Sine Wave and First 5 Harmonics");
            axis(app.UIAxes,[0,2/freq,-1,1]);
            for n = 1:6
                plot(app.UIAxes,t,harmonics(1:(2*fs/freq),n), '-', "LineWidth",1.5);
                hold (app.UIAxes, "on");
            end
            hold (app.UIAxes, "off")
            
            %graph saw wave
            title(app.UIAxes2, "Additive Synthesis Wave");
            axis(app.UIAxes2,[0,2/freq,-1,1]);
            saw = generateSaw(harmonics);
            plot(app.UIAxes2,t,saw(1:(2*fs/freq)), '-', "LineWidth",1.5);
            hold (app.UIAxes2, "off")

        %play tone for 10 seconds with 20 harmonics
        soundsc(saw,fs,16);
        end

        % Callback function
        function FrequencyEditFieldValueChanged(app, event)

        end

        % Button pushed function: StopButton
        function stop(app, event)
            app.StopButton.Enable = "off";
            app.SubmitButton.Enable = "on";
            app.FrequencyEditField.Enable = "on";
            app.Knob.Enable = "on";
            app.Knob_2.Enable = "on";
            app.Knob_3.Enable = "on";
            app.Knob_4.Enable = "on";
            app.Knob_5.Enable = "on";
            app.Knob_6.Enable = "on";
            app.Knob_7.Enable = "on";
            app.Knob_8.Enable = "on";
            app.Knob_9.Enable = "on";
            app.Knob_10.Enable = "on";
            clear sound;
        end

        % Button pushed function: resetButton
        function defaultTimbre(app, event)
            app.Knob.Value = 0;
            app.Knob_2.Value = 0;
            app.Knob_3.Value = 0;
            app.Knob_4.Value = 0;
            app.Knob_5.Value = 0;
            app.Knob_6.Value = 0;
            app.Knob_7.Value = 0;
            app.Knob_8.Value = 0;
            app.Knob_9.Value = 0;
            app.Knob_10.Value = 0;

        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.FrequencyTimbreManipulatorv10UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {456, 456};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {390, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create FrequencyTimbreManipulatorv10UIFigure and hide until all components are created
            app.FrequencyTimbreManipulatorv10UIFigure = uifigure('Visible', 'off');
            app.FrequencyTimbreManipulatorv10UIFigure.AutoResizeChildren = 'off';
            app.FrequencyTimbreManipulatorv10UIFigure.Position = [100 100 718 456];
            app.FrequencyTimbreManipulatorv10UIFigure.Name = 'Frequency-Timbre Manipulator v1.0';
            app.FrequencyTimbreManipulatorv10UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.FrequencyTimbreManipulatorv10UIFigure);
            app.GridLayout.ColumnWidth = {390, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create SubmitButton
            app.SubmitButton = uibutton(app.LeftPanel, 'push');
            app.SubmitButton.ButtonPushedFcn = createCallbackFcn(app, @submit, true);
            app.SubmitButton.Position = [249 7 66 38];
            app.SubmitButton.Text = 'Submit';

            % Create StopButton
            app.StopButton = uibutton(app.LeftPanel, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @stop, true);
            app.StopButton.Enable = 'off';
            app.StopButton.Position = [314 7 71 38];
            app.StopButton.Text = 'Stop';

            % Create InputdesiredfrequencyandclickSubmittoseegraphsofthewaveLabel
            app.InputdesiredfrequencyandclickSubmittoseegraphsofthewaveLabel = uilabel(app.LeftPanel);
            app.InputdesiredfrequencyandclickSubmittoseegraphsofthewaveLabel.Position = [13 319 261 56];
            app.InputdesiredfrequencyandclickSubmittoseegraphsofthewaveLabel.Text = {'Input desired frequency and timbre parameters '; 'and click "Submit" to see graphs of the wave.'};

            % Create FrequencyEditFieldLabel
            app.FrequencyEditFieldLabel = uilabel(app.LeftPanel);
            app.FrequencyEditFieldLabel.HorizontalAlignment = 'right';
            app.FrequencyEditFieldLabel.FontWeight = 'bold';
            app.FrequencyEditFieldLabel.Position = [26 15 65 22];
            app.FrequencyEditFieldLabel.Text = 'Frequency';

            % Create FrequencyEditField
            app.FrequencyEditField = uieditfield(app.LeftPanel, 'numeric');
            app.FrequencyEditField.Limits = [1 1000];
            app.FrequencyEditField.RoundFractionalValues = 'on';
            app.FrequencyEditField.FontWeight = 'bold';
            app.FrequencyEditField.Position = [105 15 100 22];
            app.FrequencyEditField.Value = 440;

            % Create TimbreLabel
            app.TimbreLabel = uilabel(app.LeftPanel);
            app.TimbreLabel.FontWeight = 'bold';
            app.TimbreLabel.Position = [277 336 45 22];
            app.TimbreLabel.Text = 'Timbre';

            % Create resetButton
            app.resetButton = uibutton(app.LeftPanel, 'push');
            app.resetButton.ButtonPushedFcn = createCallbackFcn(app, @defaultTimbre, true);
            app.resetButton.Position = [321 336 56 23];
            app.resetButton.Text = '(reset)';

            % Create Knob
            app.Knob = uiknob(app.LeftPanel, 'continuous');
            app.Knob.Limits = [0 1];
            app.Knob.MajorTicks = [0 1];
            app.Knob.MinorTicks = [0.25 0.5 0.75];
            app.Knob.Position = [17 244 56 56];

            % Create Label
            app.Label = uilabel(app.LeftPanel);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontWeight = 'bold';
            app.Label.Position = [32 253 25 22];
            app.Label.Text = '1';

            % Create Knob_2
            app.Knob_2 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_2.Limits = [0 1];
            app.Knob_2.MajorTicks = [0 1];
            app.Knob_2.MinorTicks = [0.25 0.5 0.75];
            app.Knob_2.Position = [90 244 56 56];

            % Create Label_2
            app.Label_2 = uilabel(app.LeftPanel);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.FontWeight = 'bold';
            app.Label_2.Position = [105 253 25 22];
            app.Label_2.Text = '2';

            % Create Knob_3
            app.Knob_3 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_3.Limits = [0 1];
            app.Knob_3.MajorTicks = [0 1];
            app.Knob_3.MinorTicks = [0.25 0.5 0.75];
            app.Knob_3.Position = [163 244 56 56];

            % Create Label_3
            app.Label_3 = uilabel(app.LeftPanel);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontWeight = 'bold';
            app.Label_3.Position = [178 253 25 22];
            app.Label_3.Text = '3';

            % Create Knob_4
            app.Knob_4 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_4.Limits = [0 1];
            app.Knob_4.MajorTicks = [0 1];
            app.Knob_4.MinorTicks = [0.25 0.5 0.75];
            app.Knob_4.Position = [234 244 56 56];

            % Create Label_4
            app.Label_4 = uilabel(app.LeftPanel);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontWeight = 'bold';
            app.Label_4.Position = [249 253 25 22];
            app.Label_4.Text = '4';

            % Create Knob_5
            app.Knob_5 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_5.Limits = [0 1];
            app.Knob_5.MajorTicks = [0 1];
            app.Knob_5.MinorTicks = [0.25 0.5 0.75];
            app.Knob_5.Position = [306 244 56 56];

            % Create Label_5
            app.Label_5 = uilabel(app.LeftPanel);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.FontWeight = 'bold';
            app.Label_5.Position = [321 253 25 22];
            app.Label_5.Text = '5';

            % Create Knob_6
            app.Knob_6 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_6.Limits = [0 1];
            app.Knob_6.MajorTicks = [0 1];
            app.Knob_6.MinorTicks = [0.25 0.5 0.75];
            app.Knob_6.Position = [17 162 56 56];

            % Create Label_6
            app.Label_6 = uilabel(app.LeftPanel);
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.FontWeight = 'bold';
            app.Label_6.Position = [32 171 25 22];
            app.Label_6.Text = '6';

            % Create Knob_7
            app.Knob_7 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_7.Limits = [0 1];
            app.Knob_7.MajorTicks = [0 1];
            app.Knob_7.MinorTicks = [0.25 0.5 0.75];
            app.Knob_7.Position = [90 162 56 56];

            % Create Label_7
            app.Label_7 = uilabel(app.LeftPanel);
            app.Label_7.HorizontalAlignment = 'center';
            app.Label_7.FontWeight = 'bold';
            app.Label_7.Position = [103 171 25 22];
            app.Label_7.Text = '7';

            % Create Knob_8
            app.Knob_8 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_8.Limits = [0 1];
            app.Knob_8.MajorTicks = [0 1];
            app.Knob_8.MinorTicks = [0.25 0.5 0.75];
            app.Knob_8.Position = [163 162 56 56];

            % Create Label_8
            app.Label_8 = uilabel(app.LeftPanel);
            app.Label_8.HorizontalAlignment = 'center';
            app.Label_8.FontWeight = 'bold';
            app.Label_8.Position = [177 171 25 22];
            app.Label_8.Text = '8';

            % Create Knob_9
            app.Knob_9 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_9.Limits = [0 1];
            app.Knob_9.MajorTicks = [0 1];
            app.Knob_9.MinorTicks = [0.25 0.5 0.75];
            app.Knob_9.Position = [234 162 56 56];

            % Create Label_9
            app.Label_9 = uilabel(app.LeftPanel);
            app.Label_9.HorizontalAlignment = 'center';
            app.Label_9.FontWeight = 'bold';
            app.Label_9.Position = [249 171 25 22];
            app.Label_9.Text = '9';

            % Create Knob_10
            app.Knob_10 = uiknob(app.LeftPanel, 'continuous');
            app.Knob_10.Limits = [0 1];
            app.Knob_10.MajorTicks = [0 1];
            app.Knob_10.MinorTicks = [0.25 0.5 0.75];
            app.Knob_10.Position = [306 162 56 56];

            % Create Label_10
            app.Label_10 = uilabel(app.LeftPanel);
            app.Label_10.HorizontalAlignment = 'center';
            app.Label_10.FontWeight = 'bold';
            app.Label_10.Position = [321 171 25 22];
            app.Label_10.Text = '10';

            % Create Harmonics110normalizedto1Clickresetfordefault1nnLabel
            app.Harmonics110normalizedto1Clickresetfordefault1nnLabel = uilabel(app.LeftPanel);
            app.Harmonics110normalizedto1Clickresetfordefault1nnLabel.Position = [18 109 347 30];
            app.Harmonics110normalizedto1Clickresetfordefault1nnLabel.Text = {'Harmonics 1-10, normalized to 1. Click reset for default (1/n)^n'; 'harmonic series'};

            % Create FrequencyTimbreManipulatorv10Label
            app.FrequencyTimbreManipulatorv10Label = uilabel(app.LeftPanel);
            app.FrequencyTimbreManipulatorv10Label.HorizontalAlignment = 'center';
            app.FrequencyTimbreManipulatorv10Label.FontSize = 20;
            app.FrequencyTimbreManipulatorv10Label.FontWeight = 'bold';
            app.FrequencyTimbreManipulatorv10Label.Position = [13 412 349 27];
            app.FrequencyTimbreManipulatorv10Label.Text = 'Frequency-Timbre Manipulator v1.0';

            % Create byVinithYedidiLabel
            app.byVinithYedidiLabel = uilabel(app.LeftPanel);
            app.byVinithYedidiLabel.HorizontalAlignment = 'center';
            app.byVinithYedidiLabel.FontSize = 20;
            app.byVinithYedidiLabel.Position = [121 386 141 27];
            app.byVinithYedidiLabel.Text = 'by Vinith Yedidi';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.RightPanel);
            title(app.UIAxes, 'Fundamental Wave + Harmonics')
            xlabel(app.UIAxes, 'Time (s)')
            ylabel(app.UIAxes, 'Amplitude (normalized to 1)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.YLim = [-1 1];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.Position = [1 240 327 209];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.RightPanel);
            title(app.UIAxes2, 'Saw Wave')
            xlabel(app.UIAxes2, 'Time (s)')
            ylabel(app.UIAxes2, 'Amplitude (normalized to 1)')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.XLim = [0 1];
            app.UIAxes2.YLim = [-1 1];
            app.UIAxes2.XGrid = 'on';
            app.UIAxes2.YGrid = 'on';
            app.UIAxes2.Position = [1 7 332 234];

            % Show the figure after all components are created
            app.FrequencyTimbreManipulatorv10UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = m

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.FrequencyTimbreManipulatorv10UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.FrequencyTimbreManipulatorv10UIFigure)
        end
    end
end