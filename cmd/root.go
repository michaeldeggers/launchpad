package cmd

import (
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "launchpad",
	Short: "A CLI for scaffolding fully deployable services",
	Long:  `Launchpad generates ready-to-run service scaffolds that follow a consistent golden path for building, deploying, and operating services on GCP.`,
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}
